import 'package:flutter/material.dart';
import 'package:starwars/core/settings/themes.dart';
import 'package:starwars/core/preferences/theme_preferences.dart';

/// Definimos los tipos de temas que habrán en nuestro caso solo estos dos.
enum ThemeType { light, dark }

/// Provider para manejar el tema de la aplicación
class ThemeProvider extends ChangeNotifier {
  /// Preferencias del tema
  ThemePreferences themePreferences = ThemePreferences();

  /// Tema actual de la aplicación
  ThemeData currentTheme = lightTheme;

  /// Tipo de tema actual de la aplicación
  ThemeType themeType = ThemeType.light;

  /// Al inicializar el provider, definimos un tema inicial
  ThemeProvider() {
    setInitialTheme();
  }

  /// En este método se define el tema inicial de toda la app el cuál será
  /// el útlimo guardado en las preferencias del usuario.
  setInitialTheme() {
    // Iniciamos con el tema claro.
    ThemeData theme = lightTheme;

    // Buscamos el tema guardado por el usuario.
    themePreferences.getValue().then((value) {
      // Si ya se difinió un tema, es decir no es nulo
      if (value != null) {
        // Cambiamos al tema escogido.
        theme = (value == 'dark') ? darkTheme : lightTheme;
      }
      // Y actualizamos estado de la app
      currentTheme = theme;
      themeType = (theme == lightTheme) ? ThemeType.light : ThemeType.dark;
      // Notificamos a los widgets necesarios. (En este caso al widget
      // "MaterialApp")
      notifyListeners();
    });
  }

  /// Cambia el tema de toda la aplicación. Este método funciona como un toggle
  /// si el el tema actual es el oscuro cambiará al claro y viceversa. Por lo
  /// tanto no es necesario enviar ningún parámetro.
  changeCurrentTheme() {
    // Establecemos el nuevo estado de la app.
    if (currentTheme == darkTheme) {
      themeType = ThemeType.light;
      currentTheme = lightTheme;
    } else {
      themeType = ThemeType.dark;
      currentTheme = darkTheme;
    }
    // Guardamos el nuevo tema en las preferencia del tema del usuario.
    themePreferences.setValue(themeType.name);
    // Notificamos el cambio a los widgets que estén escuchando.
    // En este caso el widget "MaterialApp"
    notifyListeners();
  }
}
