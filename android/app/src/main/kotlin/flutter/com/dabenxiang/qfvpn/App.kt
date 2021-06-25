package flutter.com.dabenxiang.qfvpn

import android.app.Application
import android.content.Context
import com.github.kr328.clash.common.Global
import com.github.kr328.clash.common.compat.currentProcessName
import com.github.kr328.clash.common.log.Log
import flutter.com.dabenxiang.qfvpn.log.DebugLogTree
import flutter.com.dabenxiang.qfvpn.remote.Remote
import timber.log.Timber

@Suppress("unused")
class App: Application() {

    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)

        Global.init(this)
    }

    override fun onCreate() {
        super.onCreate()

        if(BuildConfig.DEBUG) {
            Timber.plant(DebugLogTree())
        }

        val processName = currentProcessName

        Log.d("Process $processName started")

        if (processName == packageName) {
            Remote.launch()
        }
    }

    fun finalize() {
        Global.destroy()
    }
}