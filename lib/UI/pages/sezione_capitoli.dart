import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/lingua_providers.dart';
import '../widgets/bottoni_personalizzati.dart';
import '../widgets/input_personalizzato.dart';
import 'dettaglio_capitolo.dart';

class SezioneCapitoli extends StatefulWidget {
  const SezioneCapitoli({super.key});

  @override
  State<SezioneCapitoli> createState() => _SezioneCapitoliState();
}

class _SezioneCapitoliState extends State<SezioneCapitoli> {
  final List<Capitolo> _capitoli = [
    Capitolo(
      id: "1",
      titolo: "Capitolo 1: L'inizio",
      descrizione: "Introduzione ai personaggi principali...",
      personaggiCoinvolti: ["Protagonista", "Antagonista"],
      luogo: "Foresta Incantata",
      note: "Attenzione alla descrizione dell'ambiente",
      obiettivi: "Presentare il conflitto principale",
    ),
  ];

  void _aggiungiCapitolo() {
    final linguaProvider = Provider.of<LinguaProvider>(context, listen: false);
    final TextEditingController titoloController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(linguaProvider.traduci('nuovo_capitolo')),
        content: InputPersonalizzato(
          label: linguaProvider.traduci('titolo_capitolo'),
          controller: titoloController,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(linguaProvider.traduci('annulla')),
          ),
          BottoneSalva(
            onPressed: () {
              if (titoloController.text.isNotEmpty) {
                final nuovoCapitolo = Capitolo(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  titolo: titoloController.text,
                  descrizione: "",
                  personaggiCoinvolti: [""],
                  luogo: "",
                  note: "",
                  obiettivi: "",
                );

                setState(() {
                  _capitoli.add(nuovoCapitolo);
                });

                Navigator.pop(context);
              }
            },
            testo: linguaProvider.traduci('crea_capitolo'),
          ),
        ],
      ),
    );
  }

  void _aggiornaCapitolo(Capitolo capitoloModificato) {
    setState(() {
      final index = _capitoli.indexWhere((c) => c.id == capitoloModificato.id);
      if (index != -1) {
        _capitoli[index] = capitoloModificato;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final linguaProvider = Provider.of<LinguaProvider>(context); //  PROVIDER

    return Scaffold(
      body: _capitoli.isEmpty
          ? Center(child: Text(linguaProvider.traduci('nessun_capitolo')))
          : ListView.builder(
        itemCount: _capitoli.length,
        itemBuilder: (context, index) {
          final capitolo = _capitoli[index];

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(capitolo.titolo),
              subtitle: Text(capitolo.descrizione),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DettaglioCapitolo(
                      capitolo: capitolo,
                      onSalvaModifiche: _aggiornaCapitolo,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _aggiungiCapitolo,
        child: const Icon(Icons.add),
        tooltip: linguaProvider.traduci('aggiungi'),
      ),
    );
  }
}

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
}