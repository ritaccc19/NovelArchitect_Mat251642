// lib/UI/widgets/bottoni_personalizzati.dart
import 'package:flutter/material.dart';
import 'package:novelarchitect/UI/widgets/tema_mio.dart';

class BottoneSalva extends StatelessWidget {
  final VoidCallback onPressed;
  final String testo;

  const BottoneSalva({super.key, required this.onPressed, this.testo = "Salva"});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.save),
      label: Text(testo),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryPink,
        foregroundColor: Colors.white,
      ),
    );
  }
}