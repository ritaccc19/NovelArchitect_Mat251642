import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:novelarchitect/providers/book_context_provider.dart';
import 'package:novelarchitect/providers/cover_provider.dart';
import 'package:provider/provider.dart';
import 'UI/pages/genere_setup_screen.dart';
import 'firebase_options.dart';


// Providers (solo quelli necessari)
import 'package:novelarchitect/providers/lingua_providers.dart';
import 'package:novelarchitect/providers/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// UI
import 'package:novelarchitect/UI/widgets/tema_mio.dart';
import 'package:novelarchitect/UI/pages/login_screen.dart';
import 'package:novelarchitect/UI/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print(' Firebase inizializzato');
  } catch (e) {
    print(' Firebase error: $e');
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CoverProvider()),
        ChangeNotifierProvider(create: (_) => BookContextProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LinguaProvider()),

      ],
      child: Builder(
        builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            title: 'Novel Architect',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const AppEntryPoint(), //  punto di ingresso
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    // 1️ Carico il contesto del libro (genere) UNA SOLA VOLTA
    final bookProvider = context.read<BookContextProvider>();
    final coverProvider = context.read<CoverProvider>();

    return FutureBuilder(
      future: Future.wait([
        bookProvider.caricaGenere(),
        coverProvider.loadCover(),
      ]),

      builder: (context, genereSnapshot) {

        //  Attendo il caricamento del genere
        if (genereSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Caricamento...'),
                ],
              ),
            ),
          );
        }

        // 2️ Dopo aver caricato il genere, controllo l'autenticazione
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text('Caricamento...'),
                    ],
                  ),
                ),
              );
            }

            final isLoggedIn = snapshot.hasData && snapshot.data != null;

            // NON loggato → Login
            if (!isLoggedIn) {
              return const LoginScreen();
            }

            //  Loggato ma GENERE non ancora scelto → Setup iniziale
            final hasGenere = context.watch<BookContextProvider>().haGenere;
            if (!hasGenere) {
              return const GenereSetupScreen();
            }

            //  Loggato + genere presente → App principale
            return const Layout();
          },
        );
      },
    );
  }
}
