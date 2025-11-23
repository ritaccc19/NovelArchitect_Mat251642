
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:novelarchitect/UI/pages/home_screen.dart';
import 'UI/widgets/tema_mio.dart';
import 'UI/layout.dart';

void main() async {

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NovelArchitect',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          bottomNavigationBarTheme: AppTheme.bottomNavBarTheme(),),
      home: const Layout(),
    );
  }
}
