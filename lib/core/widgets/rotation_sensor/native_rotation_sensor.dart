import 'dart:io';

import 'package:flutter/services.dart';

import 'rotation_event.dart';
import 'sensor_const.dart';

/// Implemetación del llamado al código nativo.
class NativeRotationSensor {
  // Establecemos el nombre del canal
  static const _methodChannel = MethodChannel('com.jahyrm.starwars/rotation');

  // Establecemos un canal de eventos
  static EventChannel? _eventChannel;

  // Establecemos un flujo de datos
  static Stream<RotationEvent>? _sensorStream;

  /// Este método es llamado, para comprobar con código nativo, si el sensor
  /// de rotación del dispositivo está disponible.
  static Future<bool> isSensorAvailable() async {
    final bool isSensorAvailable = await _methodChannel.invokeMethod(
      'is_sensor_available',
    );
    return isSensorAvailable;
  }

  /// Este método, registra en código nativo una petición de actualizaciones
  /// del sensor.
  static Future<Stream<RotationEvent>> sensorUpdates(
      {Duration? interval}) async {
    Stream<RotationEvent>? sensorStream = _sensorStream;
    interval = interval ?? SensorConsts.sensorDelayNormal;

    // Determinamos si ya hay un flujo de datos o no
    if (sensorStream == null) {
      // Si no existe creamos uno, creando un EventChannel en código nativo.
      // y atándolo al flujo de datos aquí en flutter.
      final args = {'interval': _transformDurationToNumber(interval)};
      var eventChannel = _eventChannel;
      if (eventChannel == null) {
        await _methodChannel.invokeMethod('start_event_channel', args);
        eventChannel = const EventChannel('com.jahyrm.starwars/rotation/11');
        _eventChannel = eventChannel;
      }
      sensorStream = eventChannel.receiveBroadcastStream().map((event) {
        return RotationEvent.fromMap(event);
      });
      _sensorStream = sensorStream;
    } else {
      // Si ya lo hay actualizamos el intervalo de refrezco.
      await updateInterval(interval: interval);
    }
    return sensorStream;
  }

  /// Actualiza la taza de refrezoc de datos del sensor.
  static Future updateInterval({Duration? interval}) async {
    return _methodChannel.invokeMethod(
      'update_interval',
      {"interval": _transformDurationToNumber(interval)},
    );
  }

  /// Transforme el objeto de duración del retraso en un valor int para cada plataforma.
  static num? _transformDurationToNumber(Duration? delay) {
    return Platform.isAndroid ? delay?.inMicroseconds : delay?.inSeconds;
  }
}
