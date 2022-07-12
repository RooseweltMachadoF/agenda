import 'package:flutter/material.dart';

class ThemeLigth {
  static final ThemeLigth instance = ThemeLigth._();

  ThemeLigth._();

  ThemeData theme = ThemeData(
      primaryColor: Color.fromRGBO(5, 19, 42, 1),
      brightness: Brightness.light,
      // textSelectionTheme: const TextSelectionThemeData(
      //   cursorColor: Colors.grey,
      //   selectionColor: Colors.blueGrey,
      // ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
          centerTitle: true, backgroundColor: Colors.blueGrey[700]));
}
