import 'package:flutter/material.dart';
import 'package:starwars/core/screens/screen_base.dart';
import 'package:starwars/core/utils/utils.dart';

enum ConnectionInfo { loading, error, empty }

/// Esta es una pantalla genérica, que muestra información correspondiente
/// a los que sucede cuando se hace una llamada a internet.
class ConnectionInfoScreen extends StatefulWidget {
  final ConnectionInfo type;
  final String? customMessage;
  final bool showMessage;
  final double iconSize;

  const ConnectionInfoScreen({
    Key? key,
    required this.type,
    this.customMessage,
    this.showMessage = true,
    this.iconSize = 100,
  }) : super(key: key);

  @override
  State<ConnectionInfoScreen> createState() => _ConnectionInfoScreenState();
}

class _ConnectionInfoScreenState extends State<ConnectionInfoScreen> {
  @override
  Widget build(BuildContext context) {
    String title;
    Widget child;
    if (widget.type == ConnectionInfo.empty) {
      title = 'Información';
      child = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info, size: widget.iconSize),
            if (widget.showMessage) const SizedBox(height: 8.0),
            if (widget.showMessage)
              Text(
                Utils.capitalize(
                    widget.customMessage ?? 'No se obtuvieron datos.'),
              )
          ],
        ),
      );
    } else if (widget.type == ConnectionInfo.error) {
      title = 'Error';
      child = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error,
                color: Colors.red.shade900, size: widget.iconSize),
            if (widget.showMessage) const SizedBox(height: 8.0),
            if (widget.showMessage)
              Text(
                Utils.capitalize(
                    widget.customMessage ?? 'Ocurrió un error inesperado.'),
              )
          ],
        ),
      );
    } else {
      title = 'Cargando...';
      child = Center(
        child: SizedBox(
          height: widget.iconSize,
          width: widget.iconSize,
          child: const CircularProgressIndicator(),
        ),
      );
    }
    return ScreenBase(
      title: title,
      expandBody: true,
      child: child,
    );
  }
}
