// lib/game/models.dart

class Dino {
  double y = 0, velocity = 0;
  bool isFloating = false;
}

class Obstacle {
  double x;
  Obstacle({required this.x});

  void update(double currentSpeed) {
    x -= currentSpeed;
  }
}
