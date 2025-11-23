// lib/UI/widgets/tema_mio.dart
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryPink = Color(0xFFE91E63); // Rosa che ho scelto come principale
  static const Color secondaryPink = Color(0xFFF8BBD0); // Rosa chiaro
  static const Color backgroundPink = Color(0xFFFCE4EC); // Rosa molto chiaro per sfondi

  //creo il tema chiaro sempre basato sul rosa
  static ThemeData get lightTheme {
    return ThemeData(
      // Colori principali
      primarySwatch: Colors.pink,
      primaryColor: primaryPink,
      colorScheme: const ColorScheme.light(
        primary: primaryPink,
        secondary: secondaryPink,
        background: Colors.white,
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: bottomNavBarTheme(),

      // AppBar theme
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

      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryPink,
        foregroundColor: Colors.white,
      ),

      // Card theme
      cardTheme: CardThemeData(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: backgroundPink,
      ),

      // Input decoration (per TextField)
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryPink),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryPink, width: 2),
        ),
        labelStyle: const TextStyle(color: primaryPink),
      ),
    );
  }

  static BottomNavigationBarThemeData bottomNavBarTheme() {
    return const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryPink,
      unselectedItemColor: Colors.grey,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }

  // Metodo aggiuntivo per snackbar theme
  static SnackBarThemeData get snackBarTheme {
    return const SnackBarThemeData(
      backgroundColor: primaryPink,
      contentTextStyle: TextStyle(color: Colors.white),
      behavior: SnackBarBehavior.floating,
    );
  }
}