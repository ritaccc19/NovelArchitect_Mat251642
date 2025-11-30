// lib/models/lingua_model.dart
//creo una classe Lingua identificata da codice nome e bandiera, la lista di lingue supportate e un metodo
//che restituisce la Lingua dal suo codice dato per argomento

class Lingua {
  final String codice; // 'it', 'en', 'es', 'fr'
  final String nome;   // 'Italiano', 'English', 'Espanol', 'Francais
  final String bandiera; // 'IT', 'ES', 'EN','FR'

  const Lingua({
    required this.codice,
    required this.nome,
    required this.bandiera,
  });

  // Lista delle lingue supportate
  static const List<Lingua> lingueSupportate = [
    Lingua(codice: 'it', nome: 'Italiano', bandiera: 'IT'),
    Lingua(codice: 'en', nome: 'English', bandiera: 'GB'),
    Lingua(codice: 'es', nome: 'Espanol', bandiera: 'ES'),
    Lingua(codice: 'fr', nome: 'Francais', bandiera: 'FR'),
  ];

  // Trova una lingua per codice
  static Lingua daCodice(String codice) {
    return lingueSupportate.firstWhere(
          (lingua) => lingua.codice == codice,
      orElse: () => lingueSupportate.first, // Default italiano
    );
  }
}