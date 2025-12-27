import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/book_context_provider.dart';
import 'home_screen.dart';

//questa è una schermata iniziale dopo il login per impostare il proprio libro e salvare LOCALMENTE il libro 
class GenereSetupScreen extends StatefulWidget {
  const GenereSetupScreen({super.key});

  @override
  State<GenereSetupScreen> createState() => _GenereSetupScreenState();
}

class _GenereSetupScreenState extends State<GenereSetupScreen> {
  String? _genereSelezionato;

  @override
  Widget build(BuildContext context) {
    final bookProvider = context.read<BookContextProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scegli il genere del tuo libro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Per personalizzare i suggerimenti, scegli il genere del romanzo.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _genereSelezionato,
              decoration: const InputDecoration(
                labelText: 'Genere',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: const [
                DropdownMenuItem(value: 'fantasy', child: Text('Fantasy')),
                DropdownMenuItem(value: 'giallo', child: Text('Giallo')),
                DropdownMenuItem(value: 'romance', child: Text('Romance')),
                DropdownMenuItem(value: 'fantascienza', child: Text('Fantascienza')),
                DropdownMenuItem(value: 'horror', child: Text('Horror')),
                DropdownMenuItem(value: 'storico', child: Text('Storico')),
                DropdownMenuItem(value: 'altro', child: Text('Altro')),
              ],
              onChanged: (value) {
                setState(() => _genereSelezionato = value);
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _genereSelezionato == null
                    ? null
                    : () async {
                  await bookProvider.setGenere(_genereSelezionato!);

                  if (!mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
                icon: const Icon(Icons.check),
                label: const Text('Conferma'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
