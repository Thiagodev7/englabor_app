import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary    = Color(0xFF00A859);
  static const Color accent     = Color(0xFF4CAF50);
  static const Color scaffoldBg = Color(0xFFF5F5F5);
  static const Color error      = Color(0xFFE53935);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,               
    primaryColor: primary,
    scaffoldBackgroundColor: scaffoldBg,

    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: accent,
      background: scaffoldBg,
      error: error,
    ),

    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      titleLarge: GoogleFonts.roboto(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
      titleMedium: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 14,
        color: Colors.black87,
      ),
      labelLarge: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      hintStyle: TextStyle(
        color: Colors.grey[500],
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // errorColor removido, usamos colorScheme.error
  );
}