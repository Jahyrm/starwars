import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Logo3D extends StatefulWidget {
  const Logo3D({Key? key}) : super(key: key);

  @override
  State<Logo3D> createState() => _Logo3DState();
}

class _Logo3DState extends State<Logo3D> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Cube(
        interactive: false,
        onSceneCreated: (Scene scene) {
          Object cube = Object(fileName: 'assets/3d_models/death_star.obj');
          cube.rotation.setValues(0, 115, 0);
          cube.updateTransform();
          scene.world.add(cube);
          scene.camera.zoom = 10;
        },
      ),
    );
  }
}
