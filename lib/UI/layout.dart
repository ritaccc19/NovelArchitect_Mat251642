//qui scriverò il layout che dovrà essere presente in tutte le schermate
//mi trovo in lib/UI/widgets/layout.dart
import 'package:flutter/material.dart';
import 'package:novelarchitect/UI/pages/impostazioni.dart';
import 'package:novelarchitect/UI/pages/suggerimenti_ispirazione.dart';
import 'package:provider/provider.dart';
import 'pages/home_screen.dart';
import 'pages/sezione_capitoli.dart';
import 'pages/luoghi.dart';
import 'pages/trama_sinossi.dart';
import 'pages/personaggi.dart';
import'../providers/lingua_providers.dart';


class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
} //dev'essere stateful perché la schermata può cambiare in base all'interazione dell'utente

class _LayoutState extends State<Layout> {
  int _currentIndex = 0;
  //aggiungo ad una lista di widget le mie schermate (che sono comunque widget)
  final List<Widget> _screens = [
    const HomeScreen(),
    const Personaggi(),
    const TramaSinossi(),
    const SezioneCapitoli(),
    const Luoghi(),
  ];

  @override
  Widget build(BuildContext context) {
    final linguaProvider = Provider.of<LinguaProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(linguaProvider.traduci('NovelArchitect:  la tua app da scrittore')),
      ),
      drawer: Drawer( //barra laterale in cui aggiungo i suggerimenti, il diario
        // Nel tuo layout.dart, aggiorna il Drawer:
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'NovelArchitect',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.lightbulb),
                title: const Text('Suggerimenti d\'ispirazione'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const InspirationScreen()),
                  );
                },
              ),


                ListTile(
                leading: const Icon(Icons.settings),
                title: Text(linguaProvider.traduci('Impostazioni')),
                onTap: () {
                  Navigator.pop(context); // Chiudi drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Impostazioni()),
                  );
                },
              ),
            ],
          ),
        ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,//scrivendo fixed faccio in modo che le etichette siano visibili sempre
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        //aggiungo quattro bottoni in una barra di navigazione, uno per ogni schermata (che ho salvato dentro la lista di widget const)
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: linguaProvider.traduci('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: linguaProvider.traduci('Personaggi')),
          BottomNavigationBarItem(icon: Icon(Icons.map), label:linguaProvider.traduci( 'Trama e Sinossi')),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: linguaProvider.traduci('Capitoli')),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: linguaProvider.traduci('Luoghi')),
        ],
      ),
    );
  }
}