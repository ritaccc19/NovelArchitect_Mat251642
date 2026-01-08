import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/firestore_service.dart';

class LinguaProvider extends ChangeNotifier {
  String _codiceLingua = 'it';
  Map<String, String> _traduzioni = {};
  final FirestoreService _firestoreService = FirestoreService();

  String get codiceLingua => _codiceLingua;

  Future<void> caricaLingua() async {
    final prefs = await _firestoreService.caricaPreferenze();
    _codiceLingua = prefs?['language'] ?? 'it';
    await _caricaFileLingua(_codiceLingua);
    notifyListeners();
  }


  Future<void> cambiaLingua(String codice) async {
    _codiceLingua = codice;
    await _caricaFileLingua(codice);

    await _firestoreService.salvaLingua(codice);

    notifyListeners();
  }


  Future<void> _caricaFileLingua(String codice) async {
    final jsonString =
    await rootBundle.loadString('assets/lang/$codice.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    _traduzioni =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String traduci(String chiave) {
    return _traduzioni[chiave] ?? chiave;
  }
}
