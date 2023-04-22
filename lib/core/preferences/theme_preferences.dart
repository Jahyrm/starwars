import 'package:shared_preferences/shared_preferences.dart';
import 'package:starwars/core/preferences/prefs_abstract_class.dart';

/// Guarda las preferencias del usuario en lo que respecta al tema.
class ThemePreferences implements SavePreferences {
  /// Obtiene el tema guardado por el usuario
  @override
  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('theme');
  }

  /// Guartda el tema seleccionado por el usuario
  @override
  Future<void> setValue(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', value.toString());
  }
}
