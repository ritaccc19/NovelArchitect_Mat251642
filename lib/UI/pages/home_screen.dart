import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/lingua_providers.dart';
import '../../providers/cover_provider.dart';
import '../layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _scegliCopertina(BuildContext context) async {
    final picker = ImagePicker();
    final coverProvider = context.read<CoverProvider>();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null) {
      await coverProvider.setCover(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final linguaProvider = Provider.of<LinguaProvider>(context);
    final coverProvider = context.watch<CoverProvider>();

    final user = FirebaseAuth.instance.currentUser;
    final nomeUtente =
        user?.displayName ?? linguaProvider.traduci('scrittore');

    final now = DateTime.now();
    String greeting;

    if (now.hour >= 6 && now.hour < 12) {
      greeting = '${linguaProvider.traduci('Buongiorno')} $nomeUtente';
    } else if (now.hour >= 12 && now.hour < 18) {
      greeting = '${linguaProvider.traduci('Buon Pomeriggio')} $nomeUtente';
    } else {
      greeting = '${linguaProvider.traduci('Buonasera')} $nomeUtente';
    }

    final File? coverFile = coverProvider.imageFile;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [

          //  SFONDO COPERTINA
            FadeTransition(
              opacity: _fadeAnimation,
              child: coverFile != null && !kIsWeb
                  ? Image.file(
                coverFile,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                'assets/default_cover.jpg',
                fit: BoxFit.cover,
              ),
            ),

          //  OVERLAY per leggibilità
          Container(
            color: Colors.black.withOpacity(0.45),
          ),

          //  CONTENUTO ANIMATO
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      greeting,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Layout(),
                          ),
                        );
                      },
                      child: Text(
                        linguaProvider.traduci('Inizia a scrivere!'),
                      ),
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton.icon(
                      onPressed: () => _scegliCopertina(context),
                      icon: const Icon(Icons.image),
                      label: Text(
                        linguaProvider.traduci('Scegli copertina'),
                      ),
                    ),

                    if (coverProvider.hasCover) ...[
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => coverProvider.clearCover(),
                        child: Text(
                          linguaProvider.traduci('Rimuovi copertina'),
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],

                    if (kIsWeb) ...[
                      const SizedBox(height: 16),
                      Text(
                        linguaProvider.traduci(
                          'La copertina personalizzata è disponibile solo su mobile',
                        ),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
