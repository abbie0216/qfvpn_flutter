package flutter.com.dabenxiang.qfvpn

import android.content.Intent
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
import java.io.FileOutputStream
import java.util.*


@RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
class MainActivity : BaseActivity() {
    private val CHANNEL = "com.example.flutter_demo/app"
    private val METHOD = "getFreeSpace"
    private val KEY = "packagename"
    private val DEFAULT_PROFILE = "defaultProfile"
    private val START_VPN = "startVPN"
    private val STOP_VPN = "stopVPN"
    private val CHECK_SERVER_RUNNING = "vpnRunning"
    private var channel: MethodChannel? = null

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
                    if(checkVPNisRunning()) {
                        result.error("400000", "VPN server is running please stop ", null)
                    } else {
                        val statue = startVPN()
                        result.success("startVPN status $statue")
                    }
                }
                STOP_VPN -> {
                    stopClashService()
                }
                CHECK_SERVER_RUNNING -> {
                    result.success(checkVPNisRunning())
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

    private fun defaultProfile() {
        launch(Dispatchers.IO) {
            withProfile {
                if(queryActive() == null) {
                    val uuid: UUID = create(Profile.Type.File, "clash.yaml")
                    val target = getConfigFile(uuid.toString())
                    applicationContext.assets.list("yaml")?.map {
                        val f =
                                FileOutputStream(applicationContext.pendingDir.resolve(target.id).absoluteFile)
                        assets.open("yaml/".plus(it)).copyTo(f)
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

}
