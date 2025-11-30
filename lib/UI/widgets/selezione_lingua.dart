// lib/UI/widgets/selezione_lingua.dart
import 'package:flutter/material.dart';
import '../../model/lingua_model.dart';

class SelezioneLingua extends StatelessWidget {
  final Lingua linguaSelezionata;
  final Function(Lingua) onLinguaCambiata;

  const SelezioneLingua({
    super.key,
    required this.linguaSelezionata,
    required this.onLinguaCambiata,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titolo sezione
            Text(
              '🌍 Lingua / Language',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Lista lingue
            ...Lingua.lingueSupportate.map((lingua) {
              return ListTile(
                leading: Text(
                  lingua.bandiera,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(lingua.nome),
                trailing: lingua.codice == linguaSelezionata.codice
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () => onLinguaCambiata(lingua),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}