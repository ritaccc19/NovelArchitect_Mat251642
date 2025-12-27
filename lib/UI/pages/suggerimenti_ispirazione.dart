import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/book_context_provider.dart';

class InspirationScreen extends StatelessWidget {
  const InspirationScreen({super.key});

  List<String> _libriConsigliati(String genere) {
    switch (genere) {
      case 'fantasy':
        return [
          'Il Signore degli Anelli — J.R.R. Tolkien',
          'Lo Hobbit — J.R.R. Tolkien',
          'Mistborn — Brandon Sanderson',
          'Il nome del vento — Patrick Rothfuss',
          'Le Cronache di Narnia — C.S. Lewis',
        ];
      case 'giallo':
        return [
          'Assassinio sull’Orient Express — Agatha Christie',
          'Dieci piccoli indiani — Agatha Christie',
          'Il mastino dei Baskerville — Arthur Conan Doyle',
          'La ragazza del treno — Paula Hawkins',
        ];
      case 'romance':
        return [
          'Orgoglio e pregiudizio — Jane Austen',
          'Io prima di te — Jojo Moyes',
          'Cime tempestose — Emily Brontë',
        ];
      case 'fantascienza':
        return [
          'Dune — Frank Herbert',
          'Fondazione — Isaac Asimov',
          'Neuromante — William Gibson',
        ];
      case 'horror':
        return [
          'Shining — Stephen King',
          'It — Stephen King',
          'Dracula — Bram Stoker',
        ];
      case 'storico':
        return [
          'I pilastri della terra — Ken Follett',
          'Il nome della rosa — Umberto Eco',
        ];
      default:
        return [
          'Scegli un classico del tuo genere preferito e analizza: protagonista, conflitto, ritmo.',
          'Leggi racconti brevi per capire struttura e finali efficaci.',
        ];
    }
  }

  List<String> _spuntiCreativi(String genere) {
    switch (genere) {
      case 'fantasy':
        return [
          'Crea una regola della magia e poi rompila (ma con conseguenze).',
          'Disegna una mappa: un luogo “proibito” deve influenzare la trama.',
          'Il protagonista ottiene un potere… che ha un costo nascosto.',
        ];
      case 'giallo':
        return [
          'Scrivi 3 sospettati e assegna a ognuno un movente credibile.',
          'Metti un indizio “vero” all’inizio che sembra insignificante.',
          'Cambia narratore: cosa succede se un testimone mente?',
        ];
      case 'romance':
        return [
          'Dai ai due personaggi un obiettivo incompatibile.',
          'Crea una scena di “vicinanza forzata” (viaggio, tempesta, lavoro).',
          'Inserisci un segreto che può rovinare tutto se rivelato.',
        ];
      default:
        return [
          'Scrivi una scena di dialogo con sottotesto: dicono A, intendono B.',
          'Aggiungi un ostacolo esterno (evento) e uno interno (paura).',
        ];
    }
  }

  String _prettyGenere(String g) {
    switch (g) {
      case 'fantasy':
        return 'Fantasy';
      case 'giallo':
        return 'Giallo';
      case 'romance':
        return 'Romance';
      case 'fantascienza':
        return 'Fantascienza';
      case 'horror':
        return 'Horror';
      case 'storico':
        return 'Storico';
      default:
        return 'Altro';
    }
  }

  @override
  Widget build(BuildContext context) {
    final genere = context.watch<BookContextProvider>().genere ?? 'altro';
    final libri = _libriConsigliati(genere);
    final spunti = _spuntiCreativi(genere);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ispirazione • ${_prettyGenere(genere)}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Suggerimenti personalizzati in base al genere del tuo romanzo',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(height: 12),

          Text(
            ' Libri consigliati',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          ...libri.map(
                (t) => ListTile(
              leading: const Icon(Icons.book),
              title: Text(t),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            ' Spunti creativi',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          ...spunti.map(
                (t) => ListTile(
              leading: const Icon(Icons.lightbulb_outline),
              title: Text(t),
            ),
          ),
        ],
      ),
    );
  }
}
