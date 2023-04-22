import 'package:flutter_test/flutter_test.dart';
import 'package:starwars/core/providers/theme_provider.dart';

void main() {
  test('Cambiar tema de la app.', () {
    final themeProvider = ThemeProvider();
    final initialTheme = themeProvider.themeType;
    themeProvider.addListener(() {
      if (initialTheme == ThemeType.light) {
        expect(themeProvider.themeType, equals(ThemeType.dark));
      } else {
        expect(themeProvider.themeType, equals(ThemeType.light));
      }
    });
    themeProvider.changeCurrentTheme();
  });
}
