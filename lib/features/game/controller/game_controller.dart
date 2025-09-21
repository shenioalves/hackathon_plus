// lib/game/game_controller.dart

import 'package:flutter/material.dart';
import 'package:hackathon_plus/features/game/controller/gamer_config.dart';
import 'dart:math';

import 'package:hackathon_plus/features/game/models.dart';

class GameController extends ChangeNotifier {
  final GameConfig config;
  final TickerProvider vsync;
  late final AnimationController animationController;

  final Dino dino = Dino();
  final List<Obstacle> obstacles = [];
  int score = 0;
  bool isGameOver = false, hasStarted = false;
  late double currentSpeed;

  final Random _random = Random();
  double _lastObstacleX = 0;

  GameController({required this.config, required this.vsync}) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(days: 99),
    );
    animationController.addListener(update);

    _lastObstacleX = config.screenWidth;
    currentSpeed = config.initialGameSpeed;
  }

  void startGame() {
    hasStarted = true;
    isGameOver = false;
    score = 0;
    dino.y = 0;
    dino.velocity = 0;
    dino.isFloating = false;
    obstacles.clear();
    _lastObstacleX = config.screenWidth;
    currentSpeed = config.initialGameSpeed;
    _generateNewObstacle();
    animationController.forward(from: 0);
    notifyListeners();
  }

  void _generateNewObstacle() {
    double newX =
        _lastObstacleX +
        config.minObstacleGap +
        _random.nextDouble() * (config.maxObstacleGap - config.minObstacleGap);
    obstacles.add(Obstacle(x: newX));
    _lastObstacleX = newX;
  }

  void update() {
    if (!hasStarted || isGameOver) return;

    currentSpeed =
        config.initialGameSpeed + (score * config.speedIncreaseFactor);

    dino.velocity +=
        dino.isFloating && dino.y < 0
            ? config.gravity * config.floatingGravityFactor
            : config.gravity;
    dino.y += dino.velocity;
    if (dino.y > 0) {
      dino.y = 0;
      dino.velocity = 0;
      dino.isFloating = false;
    }

    for (int i = 0; i < obstacles.length; i++) {
      obstacles[i].update(currentSpeed);
      if (obstacles[i].x < -config.cactusWidth) {
        obstacles.removeAt(i);
        score++;
        _generateNewObstacle();
        i--;
      }
    }

    // Colisão (usando uma área de jogo de 75% da altura da tela)
    final gameAreaHeight = config.screenHeight * 0.75;
    final dinoCenterX = config.dinoInitialX + config.dinoWidth / 2;
    final dinoCenterY =
        (gameAreaHeight - config.groundHeight - config.dinoHeight / 2) + dino.y;
    final dinoRadius = (config.dinoWidth / 2) - config.collisionPadding;

    for (var obstacle in obstacles) {
      final obstacleCenterX = obstacle.x + config.cactusWidth / 2;
      final obstacleCenterY =
          gameAreaHeight - config.groundHeight - config.cactusHeight / 2;
      final obstacleRadius = (config.cactusWidth / 2) - config.collisionPadding;

      final distance = sqrt(
        pow(dinoCenterX - obstacleCenterX, 2) +
            pow(dinoCenterY - obstacleCenterY, 2),
      );

      if (distance < dinoRadius + obstacleRadius) {
        isGameOver = true;
        animationController.stop();
        break;
      }
    }
    notifyListeners();
  }

  void jump() {
    if (!isGameOver && hasStarted && dino.y == 0) {
      dino.velocity = config.jumpVelocity;
      notifyListeners();
    }
  }

  void startFloating() {
    if (!isGameOver && hasStarted && dino.y < 0) {
      dino.isFloating = true;
      notifyListeners();
    }
  }

  void stopFloating() {
    if (dino.isFloating) {
      dino.isFloating = false;
      notifyListeners();
    }
  }

  void resetGame() => startGame();

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
