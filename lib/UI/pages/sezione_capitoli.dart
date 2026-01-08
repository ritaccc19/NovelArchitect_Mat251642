import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/lingua_providers.dart';
import '../../services/firestore_service.dart';
import '../../model/capitolo.dart';
import '../widgets/bottoni_personalizzati.dart';
import '../widgets/input_personalizzato.dart';
import 'dettaglio_capitolo.dart';

class SezioneCapitoli extends StatefulWidget {
  const SezioneCapitoli({super.key});

  @override
  State<SezioneCapitoli> createState() => _SezioneCapitoliState();
}

class _SezioneCapitoliState extends State<SezioneCapitoli> {
  final FirestoreService _firestoreService = FirestoreService();

  void _aggiungiCapitolo() {
    final linguaProvider = Provider.of<LinguaProvider>(context, listen: false);
    final TextEditingController titoloController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(linguaProvider.traduci('nuovo_capitolo')),
        content: InputPersonalizzato(
          label: linguaProvider.traduci('Titolo Capitolo'),
          controller: titoloController,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(linguaProvider.traduci('annulla')),
          ),
          BottoneSalva(
            testo: linguaProvider.traduci('crea_capitolo'),
            onPressed: () async {
              if (titoloController.text.isNotEmpty) {
                final nuovoCapitolo = Capitolo(
                  id: '',
                  titolo: titoloController.text,
                  descrizione: '',
                  personaggiCoinvolti: [],
                  luogo: '',
                  note: '',
                  obiettivi: '',
                );

                await _firestoreService.aggiungiCapitolo(nuovoCapitolo);
                if (!mounted) return;
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final linguaProvider = Provider.of<LinguaProvider>(context);

    return Scaffold(
      body: StreamBuilder<List<Capitolo>>(
        stream: _firestoreService.streamCapitoli(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(linguaProvider.traduci('nessun_capitolo')),
            );
          }

          final capitoli = snapshot.data!;

          return ListView.builder(
            itemCount: capitoli.length,
            itemBuilder: (context, index) {
              final capitolo = capitoli[index];

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
                        builder: (_) => DettaglioCapitolo(
                          capitolo: capitolo,
                          onSalvaModifiche: (Capitolo capMod) {
                            _firestoreService.aggiornaCapitolo(capMod);
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _aggiungiCapitolo,
        tooltip: linguaProvider.traduci('aggiungi'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
