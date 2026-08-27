import 'package:flutter/material.dart';

class AppTheme {
  static const Color darkBg = Color(0xFF0A0E1A);
  static const Color cardBg = Color(0xFF111827);
  static const Color cyanGlow = Color(0xFF00E5FF);
  static const Color greenNeon = Color(0xFF39FF14);
  static const Color fireRed = Color(0xFFFF1744);
  static const Color amber = Color(0xFFFFAB00);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grayText = Color(0xFF9CA3AF);
  static const Color subtleBorder = Color(0xFF1F2937);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: cyanGlow,
      colorScheme: const ColorScheme.dark(
        primary: cyanGlow,
        secondary: greenNeon,
        error: fireRed,
        surface: cardBg,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBg,
        foregroundColor: cyanGlow,
        elevation: 0,
        iconTheme: IconThemeData(color: cyanGlow),
        titleTextStyle: TextStyle(
          color: cyanGlow,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: cardBg,
      ),
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: subtleBorder, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cyanGlow.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cyanGlow.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: cyanGlow, width: 2),
        ),
        hintStyle: const TextStyle(color: grayText),
        labelStyle: const TextStyle(color: cyanGlow),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: white, fontSize: 16),
        bodyMedium: TextStyle(color: white, fontSize: 14),
        bodySmall: TextStyle(color: grayText, fontSize: 12),
        titleLarge: TextStyle(color: cyanGlow, fontSize: 22, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: white, fontSize: 18, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: grayText, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cyanGlow,
          foregroundColor: darkBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
