import 'package:flutter/material.dart';
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
    final TextEditingController titoloController = TextEditingController();

    //il dialog è un popup per aggiungere un capitolo
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuovo Capitolo'),
        content: InputPersonalizzato(
          label: 'Titolo capitolo',
          controller: titoloController,
        ),
        actions: [
          TextButton(
            //bottone per annullare l'azione
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          BottoneSalva(
            //bottone per creare un nuovo capitolo
            onPressed: () {
              if (titoloController.text.isNotEmpty) {
                final nuovoCapitolo = Capitolo(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  titolo: titoloController.text,
                  //tutti gli altri campi devono essere nulli all'inizializzazione
                  descrizione: "",
                  personaggiCoinvolti: [""],
                  luogo: "",
                  note: "",
                  obiettivi: "",
                );

                setState(() {
                  //metodo da richiamare quando un widget stateful viene modificato. Aggiorna la lista _capitoli aggiungendone uno nuovo
                  _capitoli.add(nuovoCapitolo);
                });

                Navigator.pop(context);
              }
            },
            testo: "Crea Capitolo",
          ),
        ],
      ),
    );
  }

  void _aggiornaCapitolo(Capitolo capitoloModificato) {
    //metodo che si usa quando si MODIFICA UN CAPITOLO, per esempio se si modifica il titolo, la descrizione ecc.
    setState(() {
      final index = _capitoli.indexWhere((c) => c.id == capitoloModificato.id); //cerca nella lista capitoli quello con lo stesso id del capitolo modificato
      if (index != -1) {
        _capitoli[index] = capitoloModificato; //aggiorno il capitolo modificato
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //la build del widget sezione_capitoli
    return Scaffold(
      body: _capitoli.isEmpty
          ? const Center(child: Text('Nessun capitolo ancora creato')) //se non ci sono capitoli, viene mostrato questo (ma di default ho impostato che ce n'è uno
          : ListView.builder( //se ci sono capitoli, li conto e creo una card per ogni capitolo
        itemCount: _capitoli.length,
        itemBuilder: (context, index) {
          final capitolo = _capitoli[index];

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(capitolo.titolo), //titolo
              subtitle: Text(capitolo.descrizione), //sottotitolo
              trailing: const Icon(Icons.arrow_forward),
              onTap: () { //se clicco sulla Card, mi esce
                Navigator.push( //uso il navigator per direzionare l'app verso una nuova schermata
                  context,
                  MaterialPageRoute( //la prossima scheramta sarà DettaglioCapitolo, ossia la schermata dedicata ad un singolo capitolo
                    builder: (context) => DettaglioCapitolo(
                      capitolo: capitolo, //scelgo il capitolo su cui ho cliccato
                      onSalvaModifiche: _aggiornaCapitolo, //funzione per salvare modifiche fatte al capitolo. Si tratta di una CALLBACK FUNCTION
                      //onSalvaModifiche è un campo required della schermata DettaglioCapitolo. Permette di riutilizzare il codice di aggiornaCapitolo
                      //in un altro file, cioé dettaglio_capitolo. capitoloModificato infatti gli viene dato da dettaglio_capitolo.
                    ),
                  ),
                );
              },
            ),
          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        //non aggiungo il titolo perché è gia incluso nel metodo _aggiungiCapitolo, però è un bottone che dev'essere sempre presente quindi
        //va messo nella build()
        onPressed: _aggiungiCapitolo,
        child: const Icon(Icons.add),
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