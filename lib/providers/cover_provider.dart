import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoverProvider extends ChangeNotifier {
  static const _kCoverPathKey = 'cover_image_path';

  String? _imagePath;

  String? get imagePath => _imagePath;

  File? get imageFile =>
      _imagePath != null ? File(_imagePath!) : null;

  bool get hasCover => _imagePath != null;

  /// Carica il path salvato
  Future<void> loadCover() async {
    final prefs = await SharedPreferences.getInstance();
    _imagePath = prefs.getString(_kCoverPathKey);
    notifyListeners();
  }

  /// Salva il nuovo path
  Future<void> setCover(String path) async {
    _imagePath = path;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kCoverPathKey, path);
    notifyListeners();
  }

  /// Rimuove la copertina
  Future<void> clearCover() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kCoverPathKey);
    _imagePath = null;
    notifyListeners();
  }
}
