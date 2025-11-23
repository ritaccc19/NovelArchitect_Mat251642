// mi trovo in lib/UI/pages/personaggi.dart
import 'package:flutter/material.dart';

class Personaggi extends StatelessWidget {
  const Personaggi({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Sezione: Personaggi", style: Theme.of(context).textTheme.headlineMedium));
  }
}