package flutter.com.dabenxiang.qfvpn.util

import android.content.Context
import java.io.File

val Context.logsDir: File
    get() = cacheDir.resolve("logs")