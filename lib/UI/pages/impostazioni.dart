import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/lingua_providers.dart';
import '../../providers/theme_provider.dart';

class Impostazioni extends StatelessWidget {
  const Impostazioni({super.key});

  @override
  Widget build(BuildContext context) {
    final linguaProvider = context.watch<LinguaProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(linguaProvider.traduci('Impostazioni')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- LINGUA ----
            Text(
              linguaProvider.traduci('Lingua'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: linguaProvider.codiceLingua,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.language),
              ),
              items: const [
                DropdownMenuItem(value: 'it', child: Text('Italiano')),
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'es', child: Text('Español')),
                DropdownMenuItem(value: 'fr', child: Text('Français')),
              ],
              onChanged: (value) {
                if (value != null) {
                  linguaProvider.cambiaLingua(value);
                }
              },
            ),

            const SizedBox(height: 32),

            // ---- TEMA ----
            Text(
              linguaProvider.traduci('Tema'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            SwitchListTile(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.alternaTema();
              },
            )

          ],
        ),
      ),
    );
  }
}
