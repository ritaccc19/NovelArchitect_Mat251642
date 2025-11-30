// lib/UI/widgets/tema_mio.dart
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryPink = Color(0xFFE91E63);
  static const Color secondaryPink = Color(0xFFF8BBD0);
  static const Color backgroundPink = Color(0xFFFCE4EC);

  // TEMA CHIARO
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.pink,
      primaryColor: primaryPink,
      colorScheme: const ColorScheme.light(
        primary: primaryPink,
        secondary: secondaryPink,
        background: Colors.white,
      ),

      bottomNavigationBarTheme: bottomNavBarTheme(),

      appBarTheme: const AppBarTheme(
        backgroundColor: primaryPink,
        foregroundColor: Colors.white,
        elevation: 4,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryPink,
        foregroundColor: Colors.white,
      ),


      cardTheme: CardThemeData(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: backgroundPink,
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryPink, width: 2),
        ),
        labelStyle: const TextStyle(color: primaryPink),
      ),
    );
  }

  // TEMA SCURO
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.pink,
      primaryColor: primaryPink,
      colorScheme: const ColorScheme.dark(
        primary: primaryPink,
        secondary: secondaryPink,
        background: Color(0xFF121212),
      ),

      bottomNavigationBarTheme: bottomNavBarThemeDark(),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 4,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryPink,
        foregroundColor: Colors.white,
      ),


      cardTheme: CardThemeData(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: const Color(0xFF1E1E1E),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryPink, width: 2),
        ),
        labelStyle: const TextStyle(color: primaryPink),
        fillColor: const Color(0xFF2D2D2D),
        filled: true,
      ),

      scaffoldBackgroundColor: const Color(0xFF121212),
    );
  }

  static BottomNavigationBarThemeData bottomNavBarTheme() {
    return const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryPink,
      unselectedItemColor: Colors.grey,
      elevation: 8.0,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }

  static BottomNavigationBarThemeData bottomNavBarThemeDark() {
    return const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: primaryPink,
      unselectedItemColor: Colors.grey,
      elevation: 8.0,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}