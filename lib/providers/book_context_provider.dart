import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/firestore_service.dart';


class BookContextProvider extends ChangeNotifier {
  String? _genere;
  final FirestoreService _firestoreService = FirestoreService();

  String? get genere => _genere;

  /// Carica il genere da Firestore all'avvio
  Future<void> caricaGenere() async {
    _genere = await _firestoreService.caricaGenereLibro();
    notifyListeners();
  }

  /// Salva il genere su Firestore
  Future<void> setGenere(String nuovoGenere) async {
    _genere = nuovoGenere;
    await _firestoreService.salvaGenereLibro(nuovoGenere);
    notifyListeners();
  }

  bool get haGenere => _genere != null;
}

