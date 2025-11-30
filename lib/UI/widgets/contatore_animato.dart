// lib/UI/widgets/contatore_animato.dart
import 'package:flutter/material.dart';

class ContatoreAnimato extends StatefulWidget {
  //per usarlo, serviranno questi valori in input
  final int valore;
  final int limite;
  final String etichetta;

  const ContatoreAnimato({
    super.key,
    required this.valore,
    required this.limite,
    required this.etichetta,
  });

  @override
  State<ContatoreAnimato> createState() => _ContatoreAnimatoState();
}

class _ContatoreAnimatoState extends State<ContatoreAnimato>
    with TickerProviderStateMixin {

  late AnimationController _controller; //è il regista
  late Animation<double> _animazioneNumero;
  late Animation<Color?> _animazioneColore; //dato che il colore cambia

  int _valorePrecedente = 0;

  @override
  void initState() {
    //inizializzazione dell'animazione
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _aggiornaAnimazioni();
  }

  void _aggiornaAnimazioni() {
    _animazioneNumero = Tween<double>(
      begin: _valorePrecedente.toDouble(),
      end: widget.valore.toDouble(),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _animazioneColore = ColorTween(
      begin: Colors.green,
      end: widget.valore > widget.limite ? Colors.red : Colors.green,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward(from: 0.0);
    _valorePrecedente = widget.valore;
  }

  @override
  void didUpdateWidget(ContatoreAnimato oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valore != widget.valore) {
      _aggiornaAnimazioni();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.etichetta}: ${_animazioneNumero.value.toInt()}${widget.limite > 0 ? '/${widget.limite}' : ''}',
                style: TextStyle(
                  color: _animazioneColore.value,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (widget.valore > widget.limite && widget.limite > 0)
                Text(
                  'Superato limite!',
                  style: TextStyle(
                    color: _animazioneColore.value,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
