package flutter.com.dabenxiang.qfvpn

import io.flutter.embedding.android.FlutterActivity
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.MainScope

abstract class BaseActivity: FlutterActivity(), CoroutineScope by MainScope() {
}