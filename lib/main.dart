import 'package:flutter/material.dart';
import 'package:hackathon_plus/features/game/view/dino_game_view.dart';

void main() => runApp(const MyApp());

/// Widget raiz da aplicação.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DinoGameScreen(),
    );
  }
}
