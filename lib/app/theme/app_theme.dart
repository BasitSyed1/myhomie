import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = Colors.deepOrange;
  static const Color primaryAccent = Colors.deepOrangeAccent;
  static const Color surfaceLight = Color(0xFFF5F4F9);
  static const Color background = Color(0xFFF2F2F2);
  static const Color blackish = Color(0xFF0D0B0C);
  static const Color greyDark = Color(0xFF6A7380);
  static const Color greyLight = Color(0xFF878787);

  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      );
}
