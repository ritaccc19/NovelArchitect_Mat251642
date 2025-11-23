// lib/UI/pages/home_screen.dart
import 'package:flutter/material.dart';
import '../layout.dart';//i due puntini sono per dire di uscire da pages  andare a cercare layout.dart in UI

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    //AL POSTO DI "RITA" CI SARA' IL NOME DELL'UTENTE QUANDO IMPLEMENTERO' FIREBASE
    final now = DateTime.now();
    String greeting;
    if (now.hour >= 6 && now.hour < 12) {
      greeting = "Buongiorno, Rita!";
    } else if (now.hour >= 12 && now.hour < 18) {
      greeting = "Buon pomeriggio, Rita!";
    } else {
      greeting = "Buonasera, Rita!";
    }

    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
              greeting,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Layout()),
                );
              },
              child: const Text('Inizia a scrivere!'),
            )
        ]
    )
        )
    );
  }


  // Helper per elementi del drawer
  Widget _buildDrawerItem(
      BuildContext context,
      IconData icon,
      String label,
      VoidCallback onTap,
      ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }
}