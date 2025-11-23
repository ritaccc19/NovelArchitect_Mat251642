// mi trovo in lib/UI/pages/luoghi.dart
import 'package:flutter/material.dart';

class Luoghi extends StatelessWidget {
  const Luoghi({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Sezione: Luoghi", style: Theme.of(context).textTheme.headlineMedium));
  }
}