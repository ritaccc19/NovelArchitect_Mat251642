import 'package:flutter/material.dart';
import '../widgets/bottoni_personalizzati.dart';
import '../widgets/input_personalizzato.dart';
import '../widgets/contatore_animato.dart';
import 'package:provider/provider.dart';
import '../../providers/lingua_providers.dart';

class TramaSinossi extends StatefulWidget {
  const TramaSinossi({super.key});

  @override
  State<TramaSinossi> createState() => _TramaSinossiState();
}



class _TramaSinossiState extends State<TramaSinossi> {

  final TextEditingController _tramaController = TextEditingController();
  final TextEditingController _sinossiController = TextEditingController();

  int _paroleTrama = 0;
  int _paroleSinossi = 0;

  @override
  void initState() {
    super.initState();
    _tramaController.addListener(_aggiornaContatori);
    _sinossiController.addListener(_aggiornaContatori);
  }

  int _contaParole(String testo) {
    if (testo.isEmpty) return 0;
    List<String> parole = testo.split(RegExp(r'\s+'));
    return parole.where((parola) => parola.isNotEmpty).length;
  }

  void _aggiornaContatori() {
    setState(() {
      _paroleTrama = _contaParole(_tramaController.text);
      _paroleSinossi = _contaParole(_sinossiController.text);
    });
  }


  void _salvaTrama() {
    final linguaProvider = Provider.of<LinguaProvider>(context, listen: false);
    //metodo che viene eseguito quando si preme sul bottone Salva
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(linguaProvider.traduci('Trama e sinossi salvate!'))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final linguaProvider = Provider.of<LinguaProvider>(context);
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: linguaProvider.traduci('Trama Completa')),
                Tab(text: linguaProvider.traduci('Sinossi')),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children:[
                      ContatoreAnimato(
                        //utilizzo il widget che ho creato
                        valore:_paroleTrama, //numero di parole che cambia
                        limite: 5000,
                        etichetta: linguaProvider.traduci('Parole'), //testo da mostrare
                      ),
                      Expanded(
                        child:Padding(
                          padding:const EdgeInsets.all(16.0),
                          child:InputPersonalizzato(
                            label: linguaProvider.traduci('Scrivi qui la tua trama...'),
                            controller: _tramaController,
                            maxLines:null,
                          ),
                        ),
                      ),
                    ],
                  ),

                  //tab della sinossi
                  Column(
                    children: [
                      ContatoreAnimato(
                        valore: _paroleSinossi, //numero di parole che cambia
                        limite:500, //limite parole della sinossi. Superato questo, da verde diventa rosso
                        etichetta: linguaProvider.traduci('Parole'), //testo da mostrare
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InputPersonalizzato(
                            label: linguaProvider.traduci('Scrivi qui la sinossi...'),
                            controller: _sinossiController,
                            maxLines: null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // TAB TRAMA - USA INPUT PERSONALIZZATO
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InputPersonalizzato(
                      label: linguaProvider.traduci('Scrivi qui la trama completa del tuo romanzo...'),
                      controller: _tramaController,
                      maxLines: null, //non c'è un massimo di righe nella trama
                    ),
                  ),

                  // TAB SINOSSI - USA INPUT PERSONALIZZATO
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InputPersonalizzato(
                      label: linguaProvider.traduci('Scrivi qui la sinossi (max 500 parole)...'),
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
        testo: linguaProvider.traduci("Salva"),
      ),
    );
  }
}