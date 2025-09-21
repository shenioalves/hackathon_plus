// lib/widgets/ui_overlay.dart

import 'package:flutter/material.dart';
import 'package:hackathon_plus/features/game/controller/game_controller.dart';

class UiOverlay extends StatelessWidget {
  final GameController controller;

  const UiOverlay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Pontuação
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Text(
            'PONTOS: ${controller.score}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 4.0,
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ),
        // Mensagem de Início
        if (!controller.hasStarted)
          const Center(
            child: Text(
              'Toque para Iniciar',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 4.0,
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
        // Mensagem de Game Over
        if (controller.isGameOver)
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Game Over\nToque para reiniciar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
