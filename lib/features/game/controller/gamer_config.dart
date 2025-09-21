// lib/game/config.dart

class GameConfig {
  final double screenWidth;
  final double screenHeight;

  // Tamanhos
  late final double dinoWidth, dinoHeight, groundHeight, dinoInitialX;
  late final double cactusWidth, cactusHeight;

  // Física
  late final double initialGameSpeed, speedIncreaseFactor;
  late final double jumpVelocity, gravity, floatingGravityFactor;
  late final double collisionPadding;
  late final double minObstacleGap;
  late final double maxObstacleGap;

  GameConfig({required this.screenWidth, required this.screenHeight}) {
    // --- Definições de Tamanho ---
    dinoWidth = screenWidth * 0.25;
    dinoHeight = dinoWidth;
    cactusWidth = screenWidth * 0.1;
    cactusHeight = dinoHeight;
    groundHeight = -10; // Chão a 5% da base da tela
    dinoInitialX = 10;

    // --- Definições de Física ---
    initialGameSpeed = screenWidth * 0.015;
    speedIncreaseFactor = screenWidth * 0.0001;
    jumpVelocity = -screenHeight * 0.025;
    gravity = screenHeight * 0.0015;
    floatingGravityFactor = 0.5;
    collisionPadding = screenWidth * 0.02;

    // Espaçamento entre obstáculos
    minObstacleGap = screenWidth * .01;
    maxObstacleGap = screenWidth * .01;
  }
}
