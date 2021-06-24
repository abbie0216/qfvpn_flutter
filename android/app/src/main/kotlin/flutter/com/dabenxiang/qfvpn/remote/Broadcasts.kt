package flutter.com.dabenxiang.qfvpn.remote

import android.app.Application
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import com.github.kr328.clash.common.constants.Intents
import com.github.kr328.clash.common.log.Log

class Broadcasts(private val context: Application) {
    interface Observer {
        fun onServiceRecreated()
        fun onStarted()
        fun onStopped(cause: String?)
        fun onProfileChanged()
        fun onProfileLoaded()
    }

    var clashRunning: Boolean = false

    private var registered = false
    private val receivers = mutableListOf<Observer>()
    private val broadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent?.`package` != context?.packageName)
                return

            when (intent?.action) {
                Intents.ACTION_SERVICE_RECREATED -> {
                    clashRunning = false

                    receivers.forEach {
                        it.onServiceRecreated()
                    }
                }
                Intents.ACTION_CLASH_STARTED -> {
                    clashRunning = true

                    receivers.forEach {
                        it.onStarted()
                    }
                }
                Intents.ACTION_CLASH_STOPPED -> {
                    clashRunning = false

                    receivers.forEach {
                        it.onStopped(intent.getStringExtra(Intents.EXTRA_STOP_REASON))
                    }
                }
                Intents.ACTION_PROFILE_CHANGED ->
                    receivers.forEach {
                        it.onProfileChanged()
                    }
                Intents.ACTION_PROFILE_LOADED -> {
                    receivers.forEach {
                        it.onProfileLoaded()
                    }
                }
            }
        }
    }

    fun addObserver(observer: Observer) {
        receivers.add(observer)
    }

    fun removeObserver(observer: Observer) {
        receivers.remove(observer)
    }

    fun register() {
        if (registered)
            return

        try {
            context.registerReceiver(broadcastReceiver, IntentFilter().apply {
                addAction(Intents.ACTION_SERVICE_RECREATED)
                addAction(Intents.ACTION_CLASH_STARTED)
                addAction(Intents.ACTION_CLASH_STOPPED)
                addAction(Intents.ACTION_PROFILE_CHANGED)
                addAction(Intents.ACTION_PROFILE_LOADED)
            })

            clashRunning = StatusClient(context).currentProfile() != null
        } catch (e: Exception) {
            Log.w("Register global receiver: $e", e)
        }
    }

    fun unregister() {
        if (!registered)
            return

        try {
            context.unregisterReceiver(broadcastReceiver)

            clashRunning = false
        } catch (e: Exception) {
            Log.w("Unregister global receiver: $e", e)
        }
    }
}