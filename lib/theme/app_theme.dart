import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF4A42D0);
  static const Color accent = Color(0xFFFF6B6B);
  static const Color accentGreen = Color(0xFF4CAF50);
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color accentYellow = Color(0xFFFFD700);
  static const Color dark = Color(0xFF1A1A2E);
  static const Color darkSecondary = Color(0xFF16213E);
  static const Color textPrimary = Color(0xFF2D2D2D);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color bgLight = Color(0xFFF8F9FF);
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color borderColor = Color(0xFFE5E7EB);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: accent,
    ),
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: bgLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: 'Cairo',
      ),
      iconTheme: IconThemeData(color: textPrimary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontFamily: 'Cairo',
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: primary, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontFamily: 'Cairo',
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: bgCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: borderColor, width: 1),
      ),
    ),
  );
}