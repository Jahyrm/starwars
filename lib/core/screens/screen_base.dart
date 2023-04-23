import 'package:flutter/material.dart';
import 'package:starwars/core/widgets/logo_3d.dart';

enum ScreenBasePadding { none, horizontal, vertical, both }

/// Este widget será la base de todas las pantallas de la aplicación, así nos
/// aseguramos que todas sean muy parecidas, y se personalizen por medio de las
/// propiedades. Por lo tanto un cambio que se realice aquí, se refleja en todas
/// las pantallas de la app que utilicen este widget, como base.
///
/// Los parámetros que se necesitan para personalizarlo, se irán agregando sobre
/// la marcha.
class ScreenBase extends StatefulWidget {
  /// Recibe un widget que será mostrado al lado izquierdo del AppBar en caso
  /// de ser enviado.
  final Widget? leftButton;

  /// Determina si se muestra el logo en el título. Por defecto si se muestra.
  final bool showLogo;

  /// Determina si se debe centrar el título. Por defecto si se muestra.
  final bool centerTitle;

  /// Muestra los widgets que se mostrarán al lado derecho en caso de ser
  /// enviados
  final List<Widget>? actionButtons;

  /// En este parámetro enviaremos si deseamos que el cuerpo de la pantala
  /// tenga un padding. Si no se envía, no se agregará ningún padding.
  final ScreenBasePadding paddingMode;

  /// Tamaño del margen a aplicar en caso de ser necesario
  final double paddingSize;

  /// Determina si el widget hijo debe ocupar toda la pantalla.
  final bool expandBody;

  /// Determina si encerramos el widget hijo en un scroll.
  final bool wrapInScroll;

  /// Determina la dirección del scroll
  final Axis scrollDirection;

  /// Si el usuario envía su propio floating Action Button se utiliza si no no.
  final FloatingActionButton? floatingActionButton;

  /// Será el título que se muestra en el medio del AppBar
  final String title;

  /// Será el cuerpo de la pantalla, y será diferente en cada pantalla
  final Widget child;

  const ScreenBase({
    Key? key,
    this.leftButton,
    this.showLogo = true,
    this.centerTitle = true,
    this.actionButtons,
    this.paddingMode = ScreenBasePadding.none,
    this.paddingSize = 8.0,
    this.expandBody = false,
    this.floatingActionButton,
    this.wrapInScroll = true,
    this.scrollDirection = Axis.vertical,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  State<ScreenBase> createState() => _ScreenBaseState();
}

class _ScreenBaseState extends State<ScreenBase> {
  /// Widget hijo de esta pantalla;
  late Widget _child;

  @override
  Widget build(BuildContext context) {
    // Encerramos al widgt hijo dentro de un scroll en caso de ser necesario
    if (widget.wrapInScroll) {
      _child = SingleChildScrollView(
        scrollDirection: widget.scrollDirection,
        child: widget.child,
      );
    } else {
      _child = widget.child;
    }

    // Agregamos el margen en caso de ser necesario
    if (widget.paddingMode == ScreenBasePadding.horizontal) {
      _child = Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.paddingSize),
        child: _child,
      );
    } else if (widget.paddingMode == ScreenBasePadding.vertical) {
      _child = Padding(
        padding: EdgeInsets.symmetric(vertical: widget.paddingSize),
        child: _child,
      );
    } else if (widget.paddingMode == ScreenBasePadding.both) {
      _child = Padding(
        padding: EdgeInsets.all(widget.paddingSize),
        child: _child,
      );
    }

    // Hacemos que el widget hijo ocupe toda la pantalla en caso de ser
    // necesario.
    if (widget.expandBody) {
      _child = Column(
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(child: _child),
            ],
          )),
        ],
      );
    }
    return Scaffold(
      appBar: _appBar(),
      body: _child,
      floatingActionButton: widget.floatingActionButton,
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: widget.leftButton,
      title: Row(
        mainAxisAlignment: widget.centerTitle
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          if (widget.showLogo) const Logo3D(),
          if (widget.showLogo) const SizedBox(width: 16),
          Text(widget.title),
        ],
      ),
      actions: widget.actionButtons,
    );
  }
}
