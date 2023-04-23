import 'package:shared_preferences/shared_preferences.dart';

import 'prefs_abstract_class.dart';

/// Guarda las preferencias de favorites del usuario
class FavoritesPreferences implements SavePreferences {
  /// Obtiene los favoritos guardados por el usuario
  @override
  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('favorites');
  }

  /// Guartda los favoritos del usuario
  @override
  Future<void> setValue(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('favorites', value.toString());
  }
}
