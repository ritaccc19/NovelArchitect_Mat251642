import 'package:flutter/material.dart';
import 'package:novelarchitect/UI/pages/sezione_capitoli.dart';
import '../widgets/bottoni_personalizzati.dart';
import '../widgets/input_personalizzato.dart';
import '../widgets/sezione_titolo.dart';

class DettaglioCapitolo extends StatefulWidget {
  final Capitolo capitolo;
  final Function(Capitolo) onSalvaModifiche;

  const DettaglioCapitolo({
    super.key,
    required this.capitolo,
    required this.onSalvaModifiche,
  });

  @override
  State<DettaglioCapitolo> createState() => _DettaglioCapitoloState();
}

class _DettaglioCapitoloState extends State<DettaglioCapitolo> {
  //uso un controller per ogni input di testo
  late TextEditingController _titoloController;
  late TextEditingController _descrizioneController;
  late TextEditingController _noteController;
  late TextEditingController _obiettiviController;
  late TextEditingController _personaggiCoinvoltiController;
  late TextEditingController _luogoController;

  @override
  void initState() {
    //prendo i valori del testo da quelli già presenti nel widget capitolo di default
    super.initState();
    _titoloController = TextEditingController(text: widget.capitolo.titolo);
    _descrizioneController = TextEditingController(text: widget.capitolo.descrizione);
    _noteController = TextEditingController(text: widget.capitolo.note);
    _obiettiviController = TextEditingController(text: widget.capitolo.obiettivi);
    _luogoController = TextEditingController(text: widget.capitolo.luogo);

    // PER PERSONAGGI: unisco la lista in una stringa
    String personaggiTesto = widget.capitolo.personaggiCoinvolti.join(", ");
    _personaggiCoinvoltiController = TextEditingController(text: personaggiTesto);
  }

  void _salvaModifiche() {
    //questa funzione viene chiamata quando si vuole salvare le modifiche fatte ad un capitolo
    // PER PERSONAGGI: splitto la stringa in lista
    List<String> personaggi = _personaggiCoinvoltiController.text
        .split(',')
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();

 //creo l'oggetto capitolo modificato
    final capitoloModificato = Capitolo(
      id: widget.capitolo.id,
      titolo: _titoloController.text,
      descrizione: _descrizioneController.text,
      personaggiCoinvolti: personaggi,
      luogo: _luogoController.text,
      note: _noteController.text,
      obiettivi: _obiettiviController.text,
    );

    //lo do in inpput a onSalvaModifiche
    widget.onSalvaModifiche(capitoloModificato);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(linguaProvider.traduci('Modifiche salvate!'))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final linguaProvider = Provider.of<LinguaProvider>(context); //per cambiare la lingua

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettaglio Capitolo'),
        actions: [
          BottoneSalva(
            //se clicco il bottone salva, allora viene richiamata la funzione salvaModifiche
            onPressed: _salvaModifiche, //callback function
            testo: "Salva",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            InputPersonalizzato(
              label: 'Titolo Capitolo',
              controller: _titoloController,
            ),

            InputPersonalizzato(
              label: 'Descrizione',
              controller: _descrizioneController,
              maxLines: 5,
            ),

            InputPersonalizzato(
              label: 'Personaggi Coinvolti (separati da virgola)',
              controller: _personaggiCoinvoltiController,
            ),

            InputPersonalizzato(
              label: 'Luogo del capitolo',
              controller: _luogoController, // ✅ Nome corretto
            ),

            InputPersonalizzato(
              label: 'Note Creative',
              controller: _noteController,
              maxLines: 3,
            ),

            InputPersonalizzato(
              label: 'Obiettivi del Capitolo',
              controller: _obiettiviController,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}