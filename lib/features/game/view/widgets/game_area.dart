// lib/widgets/game_area.dart

import 'package:flutter/material.dart';
import 'package:hackathon_plus/features/game/controller/game_controller.dart';
import 'package:hackathon_plus/features/game/controller/gamer_config.dart';

class GameArea extends StatelessWidget {
  final GameController controller;

  const GameArea({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final GameConfig config = controller.config;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Fundo do Céu
        Positioned.fill(
          child: Image.asset("assets/images/ceu.png", fit: BoxFit.cover),
        ),
        // Dino
        Positioned(
          bottom: config.groundHeight - controller.dino.y,
          left: config.dinoInitialX,
          child: Image.asset(
            'assets/images/perso.png',
            width: config.dinoWidth,
            height: config.dinoHeight,
            fit: BoxFit.contain,
          ),
        ),
        // Obstáculos
        ...controller.obstacles.map((obstacle) {
          return Positioned(
            bottom: config.groundHeight,
            left: obstacle.x,
            child: Image.asset(
              'assets/images/virus.png',
              width: config.cactusWidth,
              height: config.cactusHeight,
              fit: BoxFit.contain,
            ),
          );
        }).toList(),
      ],
    );
  }
}
