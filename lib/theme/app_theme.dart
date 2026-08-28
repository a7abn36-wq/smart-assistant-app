import 'package:flutter/material.dart';

class AppTheme {
  static const Color darkBg = Color(0xFF081120);
  static const Color cardBg = Color(0xFF0E1D33);
  static const Color cyanGlow = Color(0xFF00E5FF);
  static const Color greenNeon = Color(0xFF39FF14);
  static const Color fireRed = Color(0xFFFF1744);
  static const Color amber = Color(0xFFFFAB00);
  static const Color ice = Color(0xFF9BD8F5);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grayText = Color(0xFF9CA3AF);
  static const Color subtleBorder = Color(0xFF1F2937);

  // Severity colors
  static const Color criticalRed = Color(0xFFFF1744);
  static const Color warningAmber = Color(0xFFFFB300);
  static const Color infoGreen = Color(0xFF39FF14);

  /// Neon glow box decoration helper
  static BoxDecoration glowBox(Color c, {double blur = 16, double op = 0.35, double radius = 18}) {
    return BoxDecoration(
      color: cardBg,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: c.withOpacity(0.4)),
      boxShadow: [
        BoxShadow(color: c.withOpacity(op), blurRadius: blur),
      ],
    );
  }

  /// Get severity color
  static Color severityColor(String severity) {
    switch (severity) {
      case 'critical':
        return criticalRed;
      case 'warning':
        return warningAmber;
      default:
        return infoGreen;
    }
  }

  /// Get severity icon
  static IconData severityIcon(String severity) {
    switch (severity) {
      case 'critical':
        return Icons.dangerous;
      case 'warning':
        return Icons.warning_amber;
      default:
        return Icons.info_outline;
    }
  }

  /// Get severity label in Arabic
  static String severityLabel(String severity) {
    switch (severity) {
      case 'critical':
        return 'حرج';
      case 'warning':
        return 'تحذير';
      default:
        return 'معلومة';
    }
  }

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
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
