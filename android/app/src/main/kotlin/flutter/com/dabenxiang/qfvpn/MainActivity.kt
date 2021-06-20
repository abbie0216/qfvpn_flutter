package flutter.com.dabenxiang.qfvpn

import android.os.Build
import android.os.Bundle
import android.os.Environment
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import com.github.kr328.clash.core.model.LogMessage
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


@RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
class MainActivity: BaseActivity() {
    private val CHANNEL = "com.example.flutter_demo/app"
    private val METHOD = "getFreeSpace"
    private val KEY = "packagename"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method.equals(METHOD)) {
                val bytes = getFreeSpace()
                result.success(bytes)
            } else {
                result.notImplemented()
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
}
