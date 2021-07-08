package flutter.com.dabenxiang.qfvpn

import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageInstaller
import android.os.Build
import android.os.Environment
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import com.github.kr328.clash.service.model.Profile
import com.github.kr328.clash.service.util.pendingDir
import flutter.com.dabenxiang.qfvpn.remote.FilesClient
import flutter.com.dabenxiang.qfvpn.remote.Remote
import flutter.com.dabenxiang.qfvpn.util.startClashService
import flutter.com.dabenxiang.qfvpn.util.stopClashService
import flutter.com.dabenxiang.qfvpn.util.withProfile
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.launch
import timber.log.Timber
import java.io.File
import java.io.FileOutputStream
import java.nio.charset.Charset
import java.util.*


@RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
open class MainActivity : BaseActivity() {
    private val CHANNEL = "com.example.flutter_demo/app"
    private val METHOD = "getFreeSpace"
    private val KEY = "packagename"
    private val DEFAULT_PROFILE = "defaultProfile"
    private val CONNECT_PRODILE = "connectProfile"
    private val START_VPN = "startVPN"
    private val STOP_VPN = "stopVPN"
    private val CHECK_SERVER_RUNNING = "vpnRunning"
    private val INSTALL_APP = "installApp"
    private var channel: MethodChannel? = null
    private var apkPath = ""
    private var defaultProfileUUID = ""

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel!!.setMethodCallHandler { call, result ->
            when (call.method) {
                METHOD -> {
                    val bytes = getFreeSpace()
                    result.success(bytes)
                }
                DEFAULT_PROFILE -> {
                    defaultProfile()
                    result.success(1)
                }
                START_VPN -> {
                    if(defaultProfileUUID.isEmpty()) {
                        result.error("400001", "connect profile not set. ", null)
                    } else if(checkVPNisRunning()) {
                        result.error("400000", "VPN server is running please stop ", null)
                    } else {
                        val statue = startVPN()
                        result.success(statue)
                    }
                }
                STOP_VPN -> {
                    stopClashService()
                    result.success("stopVPN...")
                }
                CHECK_SERVER_RUNNING -> {
                    result.success(checkVPNisRunning())
                }
                INSTALL_APP -> {
                    apkPath = call.argument<String>("path").toString()
                    Timber.d("@@ install path is $apkPath")
                    if (apkPath != null) {
                        installApk(this, apkPath)
                    }
                    result.success(1)
                }
                CONNECT_PRODILE -> {
                    setConnectVPNProfile(
                        call.argument<String>("type").toString(),
                        call.argument<String>("server").toString(),
                        call.argument<String>("port").toString(),
                        call.argument<String>("cipher").toString(),
                        call.argument<String>("password").toString(),
                        call.argument<String>("udp").toString(),
                    )
                    result.success(1)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getFreeSpace(): Long {
        return try {
            val freeSpace = Environment.getRootDirectory().freeSpace
            freeSpace
        } catch (e: Exception) {
            e.printStackTrace()
            0
        }
    }

    private fun setConnectVPNProfile(
            type: String, server: String, port: String,
            cipher: String, password: String, udp: String) {
        launch(Dispatchers.IO) {
            withProfile {
                if(queryActive() != null) {
                    val profile = queryActive()
                    delete(profile!!.uuid);
                }
                val uuid: UUID = create(Profile.Type.File, "clash.yaml")
                val target = getConfigFile(uuid.toString())
                applicationContext.assets.list("yaml")?.map {
                    val f =
                            FileOutputStream(applicationContext.pendingDir.resolve(target.id).absoluteFile)
                    val content = String.format(assets.open("yaml/".plus(it)).readBytes().toString(Charsets.UTF_8),
                            type,
                            server,
                            port,
                            cipher,
                            "\"$password\"",
                            udp
                    )
                    f.write(content.toByteArray())
                }
                val profile = queryByUUID(uuid)
                patch(profile!!.uuid, profile.name, profile.source, profile.interval)

                coroutineScope {
                    commit(profile.uuid)
                }
                setActive(profile)
            }
        }
    }

    private fun defaultProfile() {
        launch(Dispatchers.IO) {
            withProfile {
                if(queryActive() != null) {
                    defaultProfileUUID = queryActive()?.uuid.toString()
                }
            }
        }
    }

    private suspend fun getConfigFile(uuid: String): com.github.kr328.clash.design.model.File {
        val client = FilesClient(applicationContext)
        val files = client.list(uuid)
        return files.firstOrNull { it.id.endsWith("config.yaml") }!!
    }

    private fun checkVPNisRunning(): Boolean {
        return Remote.broadcasts.clashRunning
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if(requestCode == 100 && resultCode == RESULT_OK) {
            startClashService()
            channel?.invokeMethod("VPN_Permission", true)
        } else {
            channel?.invokeMethod("VPN_Permission", false)
            Timber.d("@@ cancel vpn bind...")
        }
    }

    private fun startVPN(): Int {
        val vpnRequest = startClashService()

        try {
            return if (vpnRequest != null) {
                startActivityForResult(vpnRequest, 100)
                -1
            } else {
                startClashService()
                0
            }
        } catch (e: Exception) {
            Toast.makeText(applicationContext, getString(R.string.unable_to_start_vpn), Toast.LENGTH_LONG).show()
        }
        return -2
    }

    private fun installApk(context: Context, path: String) {
        val session: PackageInstaller.Session?
        try {
            val packageInstaller = context!!.packageManager.packageInstaller
            val sessionParams =
                    PackageInstaller.SessionParams(PackageInstaller.SessionParams.MODE_FULL_INSTALL)
            val sessionId = packageInstaller.createSession(sessionParams)
            session = packageInstaller.openSession(sessionId)

            addApkToInstallSession(path, session)

            val intent = Intent(context, MainActivity::class.java)
            intent.action = PACKAGE_INSTALLED_ACTION

            val pendingIntent = PendingIntent.getActivity(context, 1010, intent, 0)
            session.commit(pendingIntent.intentSender)
        } catch (e: java.lang.Exception) {
            e.printStackTrace()
        }
    }

    private fun addApkToInstallSession(apkName: String, session: PackageInstaller.Session) {
        val packageInSession = session.openWrite("package", 0, -1)
        val buffer = ByteArray(65535)
        File(apkName).inputStream().let {
            it.buffered().let { input ->
                while (true) {
                    val sz = input.read(buffer)
                    if (sz <= 0) break
                    packageInSession.write(buffer, 0, sz)
                }
                input.close()
            }
            it.close()
            packageInSession.close()
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        Timber.d("onNewIntent intent: $intent")
        // this is for Package Installer activity callback method
        val extras = intent?.extras
        if (PACKAGE_INSTALLED_ACTION == intent?.action) {
            var message = extras?.getString(PackageInstaller.EXTRA_STATUS_MESSAGE)
            when (extras?.getInt(PackageInstaller.EXTRA_STATUS)) {
                // to call installer dialog
                PackageInstaller.STATUS_PENDING_USER_ACTION -> {
                    Timber.d("STATUS_PENDING_USER_ACTION")
                    val confirmIntent = extras.get(Intent.EXTRA_INTENT) as Intent
                    startActivity(confirmIntent)
                }
                // self-update success
                PackageInstaller.STATUS_SUCCESS -> {
                    Timber.d("STATUS_SUCCESS")
                    // install success
                    @Suppress(
                            "RECEIVER_NULLABILITY_MISMATCH_BASED_ON_JAVA_ANNOTATIONS",
                            "NULLABILITY_MISMATCH_BASED_ON_JAVA_ANNOTATIONS"
                    )
                    File(apkPath).delete()
                }
                // the user confirm cancel button or some error happen.
                PackageInstaller.STATUS_FAILURE,
                PackageInstaller.STATUS_FAILURE_ABORTED,
                PackageInstaller.STATUS_FAILURE_BLOCKED,
                PackageInstaller.STATUS_FAILURE_CONFLICT,
                PackageInstaller.STATUS_FAILURE_INCOMPATIBLE,
                PackageInstaller.STATUS_FAILURE_INVALID,
                PackageInstaller.STATUS_FAILURE_STORAGE -> {
                    Timber.d("STATUS_FAILURE ${extras.getInt(PackageInstaller.EXTRA_STATUS)}")
                    Timber.d("STATUS_FAILURE MESSAGE ${extras.getString(PackageInstaller.EXTRA_STATUS_MESSAGE)}")
                    Toast.makeText(
                            this,
                            "Some error happen...",
                            Toast.LENGTH_LONG
                    ).show()
                }
                else -> {
                    Timber.d("unrecognized status received from installer")
                }
            }
        }
    }

    companion object {
        const val PACKAGE_INSTALLED_ACTION =
                "com.example.android.apis.content.SESSION_API_PACKAGE_INSTALLED"
    }

}
