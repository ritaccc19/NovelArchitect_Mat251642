import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/capitolo.dart';


class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Utente non autenticato');
    }
    return user.uid;
  }

  Stream<List<Capitolo>> streamCapitoli() {
    return _db
        .collection('users')
        .doc(_uid)
        .collection('capitoli')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Capitolo.fromFirestore(doc))
          .toList();
    });
  }

  Future<void> aggiungiCapitolo(Capitolo capitolo) async {
    await _db
        .collection('users')
        .doc(_uid)
        .collection('capitoli')
        .add(capitolo.toMap());
  }

  Future<void> aggiornaCapitolo(Capitolo capitolo) async {
    await _db
        .collection('users')
        .doc(_uid)
        .collection('capitoli')
        .doc(capitolo.id)
        .update(capitolo.toMap());
  }


  //per salvare trama e sinossi
  Future<void> salvaTramaSinossi({
    required String trama,
    required String sinossi,
  }) async {
    await _db
        .collection('users')
        .doc(_uid)
        .collection('data')
        .doc('trama_sinossi')
        .set({
      'trama': trama,
      'sinossi': sinossi,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  ///  Salva il genere del libro
  Future<void> salvaGenereLibro(String genere) async {
    await _db
        .collection('users')
        .doc(_uid)
        .collection('data')
        .doc('book_context')
        .set({
      'genere': genere,
    });
  }

  ///  Carica il genere del libro
  Future<String?> caricaGenereLibro() async {
    final doc = await _db
        .collection('users')
        .doc(_uid)
        .collection('data')
        .doc('book_context')
        .get();

    if (!doc.exists) return null;
    return doc.data()?['genere'];
  }


  /// CARICA trama e sinossi
  Future<Map<String, String>> caricaTramaSinossi() async {
    final doc = await _db
        .collection('users')
        .doc(_uid)
        .collection('data')
        .doc('trama_sinossi')
        .get();

    if (!doc.exists) {
      return {'trama': '', 'sinossi': ''};
    }

    final data = doc.data()!;
    return {
      'trama': data['trama'] ?? '',
      'sinossi': data['sinossi'] ?? '',
    };
  }
}
