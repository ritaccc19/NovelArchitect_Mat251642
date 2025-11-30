// lib/UI/pages/impostazioni.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/lingua_providers.dart';
import '../../providers/theme_provider.dart';
import '../widgets/selezione_lingua.dart';

class Impostazioni extends StatelessWidget {
  const Impostazioni({super.key});

  @override
  Widget build(BuildContext context) {
    final linguaProvider = Provider.of<LinguaProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

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
          // In impostazioni.dart, aggiungi questa sezione:
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🌙 Tema / Theme',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // TEMA CHIARO
                      Expanded(
                        child: ListTile(
                          leading: const Icon(Icons.light_mode),
                          title: const Text('Chiaro / Light'),
                          trailing: !themeProvider.isDarkMode
                              ? const Icon(Icons.check, color: Colors.green)
                              : null,
                          onTap: () {
                            themeProvider.cambiaTema(ThemeMode.light);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Tema chiaro attivato')),
                            );
                          },
                        ),
                      ),
                      // TEMA SCURO
                      Expanded(
                        child: ListTile(
                          leading: const Icon(Icons.dark_mode),
                          title: const Text('Scuro / Dark'),
                          trailing: themeProvider.isDarkMode
                              ? const Icon(Icons.check, color: Colors.green)
                              : null,
                          onTap: () {
                            themeProvider.cambiaTema(ThemeMode.dark);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Tema scuro attivato')),
                            );
                          },
                        ),
                      ),
                    ],
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