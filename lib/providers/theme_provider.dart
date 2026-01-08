import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  final FirestoreService _firestoreService = FirestoreService();

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> caricaTema() async {
    final prefs = await _firestoreService.caricaPreferenze();
    final tema = prefs?['theme'];

    if (tema == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }

    notifyListeners();
  }

  Future<void> cambiaTema(ThemeMode nuovoTema) async {
    _themeMode = nuovoTema;
    notifyListeners();

    await _firestoreService.salvaTema(
      nuovoTema == ThemeMode.dark ? 'dark' : 'light',
    );
  }


  Future<void> alternaTema() async {
    final nuovoTema =
    _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await cambiaTema(nuovoTema);
  }
}
