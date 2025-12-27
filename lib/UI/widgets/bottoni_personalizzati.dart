// lib/UI/widgets/bottoni_personalizzati.dart
import 'package:flutter/material.dart';
import 'package:novelarchitect/UI/widgets/tema_mio.dart';

class BottoneSalva extends StatelessWidget {
  final VoidCallback? onPressed; //  Rendo nullable
  final String testo;

  const BottoneSalva({
    super.key,
    this.onPressed, //  Non required
    required this.testo,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.save),
      label: Text(testo),
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed != null
            ? AppTheme.primaryPink //  Colore normale
            : Colors.grey,          //  Grigio se disabilitato
        foregroundColor: Colors.white,
      ),
    );
  }
}