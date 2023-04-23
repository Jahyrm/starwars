package com.jahyrm.starwars

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// For Rotation
import android.content.Context
import android.hardware.SensorManager
import io.flutter.plugin.common.*

// For Battery Level
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

class MainActivity: FlutterActivity() {
    private val channel = "com.jahyrm.starwars/rotation"
    private var eventChannel: EventChannel? = null
    private var streamHandler: SensorStreamHandler? = null
    private lateinit var messenger: BinaryMessenger
    private lateinit var sensorManager: SensorManager

    override fun onDestroy() {
        removeAllListeners()
        super.onDestroy()
    }

    private fun removeAllListeners() {
        streamHandler?.stopListener()
        streamHandler = null
        eventChannel?.setStreamHandler(null)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        this.messenger = flutterEngine.dartExecutor.binaryMessenger
        this.sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager

        MethodChannel(messenger, channel).setMethodCallHandler {
            // This method is invoked on the main thread.
                call, result ->
            if (call.method == "is_sensor_available") {
                isSensorAvailable(result)
            } else if (call.method == "start_event_channel") {
                startEventChannel(call.arguments, result)
            } else if (call.method == "update_interval") {
                updateInterval(call.arguments, result)
            } else if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("NO_DISPONIBLE", "Nivel de la batería no disponible.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun isSensorAvailable(result: MethodChannel.Result) {
        val isAvailable = sensorManager.getSensorList(11).isNotEmpty()
        result.success(isAvailable)
        return
    }

    private fun startEventChannel(arguments: Any, result: MethodChannel.Result) {
        try {
            val dataMap = arguments as Map<*, *>
            val interval: Int? = dataMap["interval"] as Int?
            if (eventChannel == null) {
                val eventChannelAux = EventChannel(messenger, "com.jahyrm.starwars/rotation/11")
                val sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
                val sensorStreamHandler = SensorStreamHandler(sensorManager, 11, interval)
                eventChannelAux.setStreamHandler(sensorStreamHandler)
                eventChannel = eventChannelAux
                streamHandler = sensorStreamHandler
            }
            result.success(true)
        } catch (e: Exception) {
            e.printStackTrace()
            result.success(false)
        }
    }

    private fun updateInterval(arguments: Any, result: MethodChannel.Result) {
        try {
            val dataMap = arguments as Map<*, *>
            val interval: Int? = dataMap["interval"] as Int?
            streamHandler?.updateInterval(interval)
            result.success(true)
        } catch (e: Exception) {
            e.printStackTrace()
            result.success(false)
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int = if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        return batteryLevel
    }
}
