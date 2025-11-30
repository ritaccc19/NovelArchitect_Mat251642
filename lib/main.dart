
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:novelarchitect/UI/pages/home_screen.dart';
import 'package:novelarchitect/providers/lingua_providers.dart';
import 'package:novelarchitect/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'UI/widgets/tema_mio.dart';
import 'UI/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider( //  MULTI PROVIDER
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LinguaProvider()..caricaLinguaSalvata()),
      ],
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final linguaProvider = Provider.of<LinguaProvider>(context);
    return MaterialApp(
      title: 'NovelArchitect',
      theme: AppTheme.lightTheme, // TEMA CHIARO
      darkTheme: AppTheme.darkTheme, //  TEMA SCURO
      themeMode: themeProvider.themeMode, //TEMA ROSA
      home: const Layout(),
    );
  }
}

