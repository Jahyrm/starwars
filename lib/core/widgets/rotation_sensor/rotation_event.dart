class RotationEvent {
  /// List of data.
  List<double> data;

  /// Accuracy of the reading.
  int accuracy;

  /// Constructor.
  RotationEvent._({
    required this.data,
    required this.accuracy,
  });

  /// Construct an object from a map.
  factory RotationEvent.fromMap(Map map) {
    final data = <double>[];
    final resultData = map['data'] as List<dynamic>;
    for (var value in resultData) {
      data.add(value);
    }
    return RotationEvent._(
      accuracy: map['accuracy'],
      data: data,
    );
  }
}
