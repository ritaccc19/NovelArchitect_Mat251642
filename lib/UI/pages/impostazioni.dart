// lib/UI/pages/impostazioni.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/lingua_providers.dart';
import '../widgets/selezione_lingua.dart';

class Impostazioni extends StatelessWidget {
  const Impostazioni({super.key});

  @override
  Widget build(BuildContext context) {
    final linguaProvider = Provider.of<LinguaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(linguaProvider.traduci('impostazioni')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // SEZIONE LINGUA
          SelezioneLingua(
            linguaSelezionata: linguaProvider.linguaCorrente,
            onLinguaCambiata: (nuovaLingua) {
              linguaProvider.cambiaLingua(nuovaLingua);

              // Messaggio di conferma
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(linguaProvider.traduci(' Lingua cambiata in ${nuovaLingua.nome}')),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // ALTRE IMPOSTAZIONI (puoi aggiungere dopo)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    linguaProvider.traduci(' Altre impostazioni'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Altre impostazioni verranno aggiunte qui...',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}