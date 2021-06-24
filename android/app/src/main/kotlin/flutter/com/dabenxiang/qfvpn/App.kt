package flutter.com.dabenxiang.qfvpn

import android.app.Application
import android.content.Context
import com.github.kr328.clash.common.Global

@Suppress("unused")
class App: Application() {

    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)

        Global.init(this)
    }

    override fun onCreate() {
        super.onCreate()
    }
}