import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookContextProvider extends ChangeNotifier {
  static const _kGenereKey = 'genere_libro';

  String? _genere;

  String? get genere => _genere;

  bool get hasGenere => _genere != null && _genere!.isNotEmpty;

  /// Carica il genere salvato in locale (se esiste)
  Future<void> loadGenere() async {
    final prefs = await SharedPreferences.getInstance();
    _genere = prefs.getString(_kGenereKey);
    notifyListeners();
  }

  /// Salva il genere scelto e aggiorna lo stato
  Future<void> setGenere(String genere) async {
    _genere = genere;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kGenereKey, genere);
    notifyListeners();
  }

  /// "reset" e far riscegliere il genere
  Future<void> clearGenere() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kGenereKey);
    _genere = null;
    notifyListeners();
  }
}
