import 'package:cloud_firestore/cloud_firestore.dart';

class Capitolo {
  final String id;
  final String titolo;
  final String descrizione;
  final List<String> personaggiCoinvolti;
  final String luogo;
  final String note;
  final String obiettivi;

  Capitolo({
    required this.id,
    required this.titolo,
    required this.descrizione,
    required this.personaggiCoinvolti,
    required this.luogo,
    required this.note,
    required this.obiettivi,
  });

  factory Capitolo.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Capitolo(
      id: doc.id,
      titolo: data['titolo'] ?? '',
      descrizione: data['descrizione'] ?? '',
      personaggiCoinvolti:
      List<String>.from(data['personaggi'] ?? []),
      luogo: data['luogo'] ?? '',
      note: data['note'] ?? '',
      obiettivi: data['obiettivi'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titolo': titolo,
      'descrizione': descrizione,
      'personaggi': personaggiCoinvolti,
      'luogo': luogo,
      'note': note,
      'obiettivi': obiettivi,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
