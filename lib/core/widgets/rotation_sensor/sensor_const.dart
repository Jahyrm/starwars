class SensorConsts {
  /// Delay of 200000 microseconds between readings.
  /// Rate suitable for screen orientation changes.
  static const Duration sensorDelayNormal = Duration(microseconds: 200000);

  /// Delay of 60000 microseconds between readings.
  /// Rate suitable for UI related work.
  static const Duration sensorDelayUi = Duration(microseconds: 60000);

  /// Delay of 20000 microseconds between readings.
  /// Rate suitable for games.
  static const Duration sensorDelayGame = Duration(microseconds: 20000);

  /// Gets sensor data as fast as possible.
  static const Duration sensorDelayFastest = Duration(microseconds: 0);

  /// This sensor is reporting data with maximum accuracy.
  ///
  /// iOS does not have this kind of value so every event report [sensorStatusAccuracyHigh] of accuracy.
  static const int sensorStatusAccuracyHigh = 3;

  /// This sensor is reporting data with an average level of accuracy, calibration with the environment may improve the readings.
  ///
  /// iOS does not have this kind of value so every event report [sensorStatusAccuracyHigh] of accuracy.
  static const int sensorStatusAccuracyMedium = 2;

  /// This sensor is reporting data with low accuracy, calibration with the environment is needed.
  ///
  /// iOS does not have this kind of value so every event report [sensorStatusAccuracyHigh] of accuracy.
  static const int sensorStatusAccuracyLow = 1;
}
