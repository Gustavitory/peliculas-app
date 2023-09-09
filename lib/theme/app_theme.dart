import 'package:flutter/material.dart';

class AppTheme {
  //Colors:

  //Themes:
  static final ThemeData lightTheme = ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo));
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo));
}
