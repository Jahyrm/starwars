//theme data for each theme
import 'package:flutter/material.dart';

/// En este archivo se guardarán la definición de los temas de la app

/// Tema claro
ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light().copyWith(primary: Colors.green),
  useMaterial3: true,
  primaryColor: Colors.green,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  cardTheme: const CardTheme(color: Colors.white),
  fontFamily: 'Montserrat',
  appBarTheme: AppBarTheme(
    shadowColor: Colors.black,
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: const TextTheme(
      headline4: TextStyle(color: Colors.black, fontFamily: 'StarJedise'),
    ).headline4,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
  ),
);

/// Tema oscuro
ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark().copyWith(primary: Colors.white),
  useMaterial3: true,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  cardTheme: const CardTheme(color: Color(0xff101820)),
  fontFamily: 'Montserrat',
  iconTheme: const IconThemeData(color: Color(0xffcfcfcf)),
  appBarTheme: AppBarTheme(
    shadowColor: Colors.white,
    backgroundColor: Colors.grey,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextTheme(
      headline4: TextStyle(color: Colors.white, fontFamily: 'StarJedise'),
    ).headline4,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.grey,
  ),
);
