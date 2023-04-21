//theme data for each theme
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  cardTheme: const CardTheme(color: Color(0xff101820)),
  fontFamily: 'Lato',
  iconTheme: const IconThemeData(color: Color(0xffcfcfcf)),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextTheme(
      headline4: TextStyle(color: Colors.white),
    ).headline4,
  ),
);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: const Color(0xff29b6f6),
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  cardTheme: const CardTheme(color: Colors.white),
  fontFamily: 'Lato',
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: const TextTheme(
      headline4: TextStyle(color: Colors.black),
    ).headline4,
  ),
);
