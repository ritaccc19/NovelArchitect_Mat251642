// lib/UI/widgets/input_personalizzato.dart
import 'package:flutter/material.dart';

//questo lo riutilizzo per ogni campo input per i Text Field

class InputPersonalizzato extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int? maxLines;//lo rendo opzionale, cioè può essre null perche se è null vuol dire che non c'è un max di righe

  const InputPersonalizzato({
    //costruttore
    super.key,
    required this.label,
    required this.controller,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            alignLabelWithHint: maxLines !=  null && maxLines! >1, //dev'essere true se ho piu di una riga, ma maxLines può anche essere null
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}