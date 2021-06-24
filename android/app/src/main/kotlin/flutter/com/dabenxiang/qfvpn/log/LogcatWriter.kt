package flutter.com.dabenxiang.qfvpn.log

import android.content.Context
import com.github.kr328.clash.core.model.LogMessage
import com.github.kr328.clash.design.model.LogFile
import flutter.com.dabenxiang.qfvpn.util.logsDir
import java.io.BufferedWriter
import java.io.FileWriter

class LogcatWriter(context: Context) : AutoCloseable {
    private val file = LogFile.generate()
    private val writer = BufferedWriter(FileWriter(context.logsDir.resolve(file.fileName)))

    override fun close() {
        writer.close()
    }

    fun appendMessage(message: LogMessage) {
        writer.appendLine(FORMAT.format(message.time.time, message.level.name, message.message))
    }

    companion object {
        private const val FORMAT = "%d:%s:%s"
    }
}