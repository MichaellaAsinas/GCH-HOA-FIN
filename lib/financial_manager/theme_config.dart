import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.lightBlue,
  colorScheme: ColorScheme.light(
    primary: Colors.lightBlue,
    secondary: Colors.yellow.shade700,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor:  Color(0xFF0073AD),
    foregroundColor: Colors.white,
  ),
);