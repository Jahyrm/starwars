import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/core/providers/favorites_provider.dart';
import 'package:starwars/core/providers/theme_provider.dart';
import 'package:starwars/modules/home/screens/home_screen.dart';

void main() {
  /// Asegura que las llamadas al código nativo (por parte de provider) sean
  /// posibles al asegurar que "WidgetsFlutterBinding" se inicialice primero.
  WidgetsFlutterBinding.ensureInitialized();

  /// El cambio de tema aplica a toda la app, por lo que encierro mi materialapp
  /// con mi changenotifierprovider.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
      ],
      child: const StarWarsApp(),
    ),
  );
}

class StarWarsApp extends StatelessWidget {
  const StarWarsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StarWars App',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: const HomeScreen(),
    );
  }
}
