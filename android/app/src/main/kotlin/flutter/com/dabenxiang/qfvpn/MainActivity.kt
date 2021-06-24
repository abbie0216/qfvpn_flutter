package flutter.com.dabenxiang.qfvpn

import android.os.Build
import android.os.Environment
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import com.github.kr328.clash.service.model.Profile
import com.github.kr328.clash.service.util.pendingDir
import flutter.com.dabenxiang.qfvpn.remote.FilesClient
import flutter.com.dabenxiang.qfvpn.util.withProfile
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.launch
import java.io.FileOutputStream
import java.util.*


@RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
class MainActivity: BaseActivity() {
    private val CHANNEL = "com.example.flutter_demo/app"
    private val METHOD = "getFreeSpace"
    private val KEY = "packagename"
    private val DEFAULT_PROFILE = "defaultProfile"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                METHOD -> {
                    val bytes = getFreeSpace()
                    result.success(bytes)
                }
                DEFAULT_PROFILE -> {
                    defaultProfile()
                    result.success(true)
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
}
