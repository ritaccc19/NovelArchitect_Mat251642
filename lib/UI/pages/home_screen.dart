// lib/UI/pages/home_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/cover_provider.dart';
import '../layout.dart';//i due puntini sono per dire di uscire da pages  andare a cercare layout.dart in UI
import'../../providers/lingua_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  @override
  Widget build(BuildContext context) {
    final linguaProvider = Provider.of<LinguaProvider>(context);
    final coverProvider = context.watch<CoverProvider>();

    final user = FirebaseAuth.instance.currentUser;
    final nomeUtente = user?.displayName ?? linguaProvider.traduci('scrittore');

    final now = DateTime.now();
    String greeting;

    if (now.hour >= 6 && now.hour < 12) {
      greeting = '${linguaProvider.traduci('Buongiorno')} $nomeUtente';
    } else if (now.hour >= 12 && now.hour < 18) {
      greeting = '${linguaProvider.traduci('Buon Pomeriggio')} $nomeUtente';
    } else {
      greeting = '${linguaProvider.traduci('Buonasera')} $nomeUtente';
    }

    final File? coverFile = coverProvider.imageFile;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // SFONDO COPERTINA
          if (coverFile != null)
            Image.file(
              coverFile,
              fit: BoxFit.cover,
            ),

          //  OVERLAY per leggibilità
          Container(
            color: Colors.black.withOpacity(0.45),
          ),

          //  CONTENUTO
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  greeting,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Layout()),
                    );
                  },
                  child: Text(
                    linguaProvider.traduci('Inizia a scrivere!'),
                  ),
                ),

                const SizedBox(height: 16),

                ElevatedButton.icon(
                  onPressed: () => _scegliCopertina(context),
                  icon: const Icon(Icons.image),
                  label: Text(
                    linguaProvider.traduci('Scegli copertina'),
                  ),
                ),

                if (coverProvider.hasCover) ...[
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => coverProvider.clearCover(),
                    child: Text(
                      linguaProvider.traduci('Rimuovi copertina'),
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
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

Future<void> _scegliCopertina(BuildContext context) async {
  final picker = ImagePicker();
  final coverProvider = context.read<CoverProvider>();

  final XFile? image = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 85,
  );

  if (image != null) {
    await coverProvider.setCover(image.path);
  }
}
