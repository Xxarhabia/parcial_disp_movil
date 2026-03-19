import 'package:flutter/material.dart';

List<Color> _colorTheme = [
  Colors.redAccent,
  Colors.blueGrey,
  Colors.white
];

class AppTheme {
  final int selectColor;

  AppTheme({this.selectColor = 0});

  ThemeData getThemeData() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorTheme[selectColor],
      appBarTheme: AppBarTheme(
        backgroundColor: _colorTheme[selectColor],
      ),
      brightness: Brightness.dark
    );
  }
}