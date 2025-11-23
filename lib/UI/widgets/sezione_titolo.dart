import 'package:flutter/material.dart';
// lib/UI/widgets/sezione_titolo.dart

//in modo che i titoli abbiano tutti la stessa dimensione e grassetto
class SezioneTitolo extends StatelessWidget {
  final String titolo;

  const SezioneTitolo({super.key, required this.titolo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(titolo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
      ],
    );
  }
}
