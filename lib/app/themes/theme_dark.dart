import 'package:flutter/material.dart';

class ThemeDark {
  static final ThemeDark instance = ThemeDark._();

  ThemeDark._();

  ThemeData theme = ThemeData(
      // fontFamily: ,
      primaryColor: Colors.teal,
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.teal,
        selectionColor: Colors.tealAccent,
      ),
      fontFamily: 'Montserrat',
      appBarTheme: const AppBarTheme(
          toolbarHeight: 50,
          centerTitle: true,
          backgroundColor: Color.fromRGBO(100, 255, 218, 0.5)));
}
