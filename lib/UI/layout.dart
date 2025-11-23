//qui scriverò il layout che dovrà essere presente in tutte le schermate
//mi trovo in lib/UI/widgets/layout.dart
import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/sezione_capitoli.dart';
import 'pages/luoghi.dart';
import 'pages/trama_sinossi.dart';
import 'pages/personaggi.dart';


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
    return Scaffold(
      appBar: AppBar(
        title: const Text('NovelArchitect: la tua app da scrittore!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Impostazioni')),
              );
            },
          ),
        ],
      ),
      drawer: Drawer( //barra laterale in cui aggiungo i suggerimenti, il diario
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Benvenuta, Rita!',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.lightbulb),
              title: const Text('Suggerimenti d’ispirazione'),
              onTap: () => Navigator.pop(context),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Personaggi'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Trama e Sinossi'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Capitoli'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Luoghi'),
        ],
      ),
    );
  }
}