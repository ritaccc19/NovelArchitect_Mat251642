import 'package:flutter/material.dart';
import '../widgets/bottoni_personalizzati.dart';
import '../widgets/input_personalizzato.dart';

class TramaSinossi extends StatefulWidget {
  const TramaSinossi({super.key});

  @override
  State<TramaSinossi> createState() => _TramaSinossiState();
}



class _TramaSinossiState extends State<TramaSinossi> {
  final TextEditingController _tramaController = TextEditingController();
  final TextEditingController _sinossiController = TextEditingController();

  void _salvaTrama() {
    //metodo che viene eseguito quando si preme sul bottone Salva
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Trama e sinossi salvate!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Trama Completa'),
                Tab(text: 'Sinossi'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // TAB TRAMA - USA INPUT PERSONALIZZATO
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InputPersonalizzato(
                      label: 'Scrivi qui la trama completa del tuo romanzo...',
                      controller: _tramaController,
                      maxLines: null, //non c'è un massimo di righe nella trama
                    ),
                  ),

                  // TAB SINOSSI - USA INPUT PERSONALIZZATO
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InputPersonalizzato(
                      label: 'Scrivi qui la sinossi (max 500 parole)...',
                      controller: _sinossiController,
                      maxLines: null, // Massimo 250 righe
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //  USA BOTTONE SALVA PERSONALIZZATO (scritto in widgets)
      floatingActionButton: BottoneSalva(
        onPressed: _salvaTrama,
        testo: "Salva Tutto",
      ),
    );
  }
}