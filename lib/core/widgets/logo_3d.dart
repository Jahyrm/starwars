import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:starwars/core/widgets/rotation_sensor/native_rotation_sensor.dart';
import 'package:starwars/core/widgets/rotation_sensor/sensor_const.dart';

/// Este widget es el logo de la aplicación que se mostrará en el AppBar
class Logo3D extends StatefulWidget {
  /// Determina si el logo se puede girar con acciones del usuario. Por defecto
  /// es true es decir que sí se puede.
  final bool interactive;

  /// Determina si el logo se mueve siguiendo la rotación del dispositivo.
  /// Por defecto es [true] es decir que lo hace automáticamente.
  final bool autoStartMovement;

  const Logo3D({
    Key? key,
    this.interactive = true,
    this.autoStartMovement = true,
  }) : super(key: key);

  @override
  State<Logo3D> createState() => _Logo3DState();
}

class _Logo3DState extends State<Logo3D> {
  // Variables utilizadas para la visualización de objetos 3D.
  late Scene scene;
  late Object deathStarSphere;
  late Offset _lastFocalPoint;
  double? _lastZoom;

  // Variables necesarias para la obteción de datos de rotación del celular.

  List<double> _rotationData = List.filled(3, 0.0);
  StreamSubscription? _rotationSubscription;

  // 3D Methods
  void _handleScaleStart(ScaleStartDetails details) {
    _lastFocalPoint = details.localFocalPoint;
    _lastZoom = null;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    scene.camera.trackBall(
        toVector2(_lastFocalPoint), toVector2(details.localFocalPoint), 1.5);
    _lastFocalPoint = details.localFocalPoint;
    if (_lastZoom == null) {
      _lastZoom = scene.camera.zoom;
    } else {
      scene.camera.zoom = _lastZoom! * details.scale;
    }
    setState(() {});
  }

  // Rotations Methods
  void _checkRotationStatusAndStarMovement() async {
    bool isSensorAvailable = await NativeRotationSensor.isSensorAvailable();
    if (isSensorAvailable && widget.autoStartMovement) {
      _startMovement();
    }
  }

  Future<void> _startMovement() async {
    if (_rotationSubscription != null) return;
    final stream = await NativeRotationSensor.sensorUpdates(
      interval: SensorConsts.sensorDelayGame,
    );
    _rotationSubscription = stream.listen((sensorEvent) {
      _rotationData = sensorEvent.data;
      deathStarSphere.rotation.setValues(
        _rotationData[0] * 360,
        _rotationData[1] * 360,
        _rotationData[2] * 360,
      );
      deathStarSphere.updateTransform();
      setState(() {});
    });
  }

  void _stopMovement() {
    if (_rotationSubscription == null) return;
    _rotationSubscription?.cancel();
    _rotationSubscription = null;
  }

  @override
  void initState() {
    _checkRotationStatusAndStarMovement();
    super.initState();
    scene = Scene(
      onUpdate: () => setState(() {}),
      onObjectCreated: null,
    );
    // prevent setState() or markNeedsBuild called during build
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      deathStarSphere = Object(fileName: 'assets/3d_models/death_star.obj');
      deathStarSphere.rotation.setValues(0, 200, 0);
      deathStarSphere.updateTransform();
      scene.world.add(deathStarSphere);
      scene.camera.zoom = 10;
    });
  }

  @override
  void dispose() {
    _stopMovement();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        scene.camera.viewportWidth = constraints.maxWidth;
        scene.camera.viewportHeight = constraints.maxHeight;
        final customPaint = CustomPaint(
          painter: _CubePainter(scene),
          size: Size(constraints.maxWidth, constraints.maxHeight),
        );
        return widget.interactive
            ? GestureDetector(
                onScaleStart: _handleScaleStart,
                onScaleUpdate: _handleScaleUpdate,
                child: customPaint,
              )
            : customPaint;
      }),
    );
  }
}

class _CubePainter extends CustomPainter {
  final Scene _scene;
  const _CubePainter(this._scene);

  @override
  void paint(Canvas canvas, Size size) {
    _scene.render(canvas, size);
  }

  // We should repaint whenever the board changes, such as board.selected.
  @override
  bool shouldRepaint(_CubePainter oldDelegate) {
    return true;
  }
}

/// Convert Offset to Vector2
Vector2 toVector2(Offset value) {
  return Vector2(value.dx, value.dy);
}
