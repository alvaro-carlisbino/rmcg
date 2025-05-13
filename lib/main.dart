import 'package:flutter/material.dart';
import 'package:rmcg/core/service_locator.dart';
import 'package:rmcg/presentantion/views/character_card_screen.dart';

void main() {
  setupLocator();
  runApp(const RMCGApp());
}

class RMCGApp extends StatelessWidget {
  const RMCGApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RMCG',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const CharacterCardScreen(),
    );
  }
}
