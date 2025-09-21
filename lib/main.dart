import 'package:flutter/material.dart';
import 'dart:math';

// ===================================================================
// 1. CENTRAL DE CONTROLE DO JOGO
// Esta classe centraliza todas as variáveis de configuração.
// Para alterar a dificuldade, tamanho dos elementos ou física, mexa aqui.
// ===================================================================
class GameConfig {
  final double screenWidth;
  final double screenHeight;

  // ==========================//
  // AJUSTES DE TAMANHO (em %) //
  // ==========================//
  late final double dinoWidth; // Largura do dinossauro
  late final double dinoHeight; // Altura do dinossauro
  late final double cactusWidth; // Largura do obstáculo
  late final double cactusHeight; // Altura do obstáculo
  late final double groundHeight; // Altura do chão
  late final double dinoInitialX; // Posição inicial do dinossauro no eixo X

  // ========================//
  // AJUSTES DE FÍSICA      //
  // ========================//
  late final double initialGameSpeed; // Velocidade com que o jogo começa
  late final double
  speedIncreaseFactor; // Fator que acelera o jogo a cada ponto
  late final double jumpVelocity; // Força do impulso inicial do pulo
  late final double gravity; // Força que puxa o dinossauro para baixo
  late final double
  floatingGravityFactor; // Redutor da gravidade quando o jogador segura o toque
  late final double
  collisionPadding; // Margem de erro para a colisão (hitbox menor que o sprite)

  /// Construtor que calcula todos os valores com base no tamanho da tela.
  GameConfig({required this.screenWidth, required this.screenHeight}) {
    // --- Definições de Tamanho ---
    dinoWidth = screenWidth * 0.2;
    dinoHeight = dinoWidth;
    cactusWidth = dinoWidth / 2;
    cactusHeight = dinoHeight;
    groundHeight = screenHeight * 0.2;
    dinoInitialX = 20;

    // --- Definições de Física ---
    initialGameSpeed = 5;
    speedIncreaseFactor = .01;
    jumpVelocity = -screenHeight * 0.03;
    gravity = 1.1;
    floatingGravityFactor = .59;
    collisionPadding = screenWidth * 0.03;
  }
}

// ===================================================================
// 2. MODELOS DE DADOS
// Classes simples que representam os objetos do jogo.
// ===================================================================

/// Representa o jogador (dinossauro).
/// Guarda as informações de sua posição vertical, velocidade e estado de pulo.
class Dino {
  double y = 0; // Posição vertical (0 é o chão, valores negativos são no ar).
  double velocity =
      0; // Velocidade vertical (negativa ao pular, positiva ao cair).
  bool isFloating =
      false; // `true` se o jogador estiver segurando o toque para planar.
}

/// Representa um obstáculo.
/// Guarda apenas sua posição horizontal.
class Obstacle {
  double x; // Posição horizontal do obstáculo na tela.
  Obstacle({required this.x});

  /// Move o obstáculo para a esquerda com base na velocidade atual do jogo.
  void update(double currentSpeed) {
    x -= currentSpeed;
  }
}

// ===================================================================
// 3. CONTROLE DA LÓGICA DO JOGO
// O "cérebro" do jogo. Gerencia o estado, as atualizações e a física.
// ===================================================================
class GameController extends ChangeNotifier {
  final GameConfig config; // Configurações de tamanho e física.
  final Dino dino = Dino(); // Instância do jogador.
  final List<Obstacle> obstacles = []; // Lista de obstáculos na tela.
  int score = 0; // Pontuação atual.
  bool isGameOver = false; // `true` se o jogo terminou.
  bool hasStarted = false; // `true` se o jogo já começou.
  late double
  currentSpeed; // Velocidade atual do jogo, que aumenta com a pontuação.

  final Random _random = Random(); // Gerador de números aleatórios.
  double _lastObstacleX =
      0; // Posição do último obstáculo gerado para calcular o espaçamento.

  GameController({required this.config}) {
    _lastObstacleX = config.screenWidth;
    currentSpeed = config.initialGameSpeed;
  }

  /// Inicia ou reinicia o jogo, resetando todas as variáveis para o estado inicial.
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
    notifyListeners(); // Notifica a UI para reconstruir com o novo estado.
  }

  /// Cria um novo obstáculo e o adiciona à lista.
  void _generateNewObstacle() {
    // Define um espaçamento aleatório entre os obstáculos.
    double minGap = config.screenWidth * 0.9;
    double maxGap = config.screenWidth * 1.1;
    double newX =
        _lastObstacleX + minGap + _random.nextDouble() * (maxGap - minGap);

    obstacles.add(Obstacle(x: newX));
    _lastObstacleX = newX;
  }

  /// O loop principal do jogo, chamado a cada frame pela animação.
  void update() {
    if (!hasStarted || isGameOver)
      return; // Não faz nada se o jogo não começou ou já terminou.

    // 1. Aumenta a velocidade com base na pontuação.
    currentSpeed =
        config.initialGameSpeed + (score * config.speedIncreaseFactor);

    // 2. Atualiza a física do Dino (pulo e gravidade).
    dino.velocity += dino.isFloating && dino.y < 0
        ? config.gravity * config.floatingGravityFactor
        : config.gravity;
    dino.y += dino.velocity;
    if (dino.y > 0) {
      // Impede o dino de cair abaixo do chão.
      dino.y = 0;
      dino.velocity = 0;
      dino.isFloating = false;
    }

    // 3. Atualiza a posição dos obstáculos.
    for (int i = 0; i < obstacles.length; i++) {
      obstacles[i].update(currentSpeed);
      // Se um obstáculo saiu da tela, remove-o, aumenta a pontuação e gera um novo.
      if (obstacles[i].x < -config.cactusWidth) {
        obstacles.removeAt(i);
        score++;
        _generateNewObstacle();
        i--; // Ajusta o índice do loop após a remoção.
      }
    }

    // 4. Verifica se houve colisão.
    final padding = config.collisionPadding;
    // Cria a hitbox (caixa de colisão) do dino, um pouco menor que a imagem.
    Rect dinoRect = Rect.fromLTWH(
      config.dinoInitialX + padding,
      (config.screenHeight * 0.6 -
              config.dinoHeight -
              config.groundHeight +
              dino.y) +
          padding,
      config.dinoWidth - (padding * 2),
      config.dinoHeight - (padding * 2),
    );
    // Verifica a colisão com a hitbox de cada obstáculo.
    for (var obstacle in obstacles) {
      Rect obstacleRect = Rect.fromLTWH(
        obstacle.x + padding,
        (config.screenHeight * 0.6 -
                config.cactusHeight -
                config.groundHeight) +
            padding,
        config.cactusWidth - (padding * 2),
        config.cactusHeight - (padding * 2),
      );
      if (dinoRect.overlaps(obstacleRect)) {
        isGameOver = true; // Fim de jogo!
        break;
      }
    }

    notifyListeners(); // Notifica a UI para redesenhar os elementos nas novas posições.
  }

  /// Ação de pular.
  void jump() {
    if (!isGameOver && hasStarted && dino.y == 0) {
      dino.velocity = config.jumpVelocity;
      notifyListeners();
    }
  }

  /// Ativa a planagem (gravidade reduzida).
  void startFloating() {
    if (!isGameOver && hasStarted && dino.y < 0) {
      dino.isFloating = true;
      notifyListeners();
    }
  }

  /// Desativa a planagem.
  void stopFloating() {
    if (dino.isFloating) {
      dino.isFloating = false;
      notifyListeners();
    }
  }

  /// Atalho para reiniciar o jogo.
  void resetGame() => startGame();
}

// ===================================================================
// 4. A UI (INTERFACE DO USUÁRIO)
// Constrói a tela e responde às interações do jogador.
// ===================================================================
void main() => runApp(const MyApp());

/// Widget raiz da aplicação.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DinoGame(),
    );
  }
}

/// O StatefulWidget principal que gerencia o estado do jogo.
class DinoGame extends StatefulWidget {
  const DinoGame({super.key});
  @override
  State<DinoGame> createState() => _DinoGameState();
}

/// A classe de estado que gerencia o ciclo de vida e a construção da UI do jogo.
class _DinoGameState extends State<DinoGame>
    with SingleTickerProviderStateMixin {
  late final AnimationController
  _animationController; // Controla o "tick" do jogo (game loop).
  GameController? _gameController; // A instância do cérebro do jogo.

  @override
  void initState() {
    super.initState();
    // Cria o controller da animação que vai chamar o `update` do jogo repetidamente.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(days: 99),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Inicializa o GameController aqui, pois é o primeiro lugar seguro para usar o `MediaQuery`.
    if (_gameController == null) {
      final size = MediaQuery.of(context).size;
      final config = GameConfig(
        screenWidth: size.width,
        screenHeight: size.height,
      );
      _gameController = GameController(config: config);

      // Conecta o "tick" da animação ao loop `update` do nosso jogo.
      _animationController.addListener(() => _gameController!.update());
    }
  }

  @override
  void dispose() {
    // Libera os recursos dos controllers para evitar vazamento de memória.
    _animationController.dispose();
    _gameController?.dispose();
    super.dispose();
  }

  /// Lida com o início do toque na tela.
  void _handleTapDown(TapDownDetails details) {
    if (_gameController == null) return;
    if (_gameController!.isGameOver) {
      _gameController!.resetGame();
      _animationController.forward(from: 0);
    } else if (!_gameController!.hasStarted) {
      _gameController!.startGame();
      _animationController.forward(from: 0);
    } else {
      _gameController!.jump();
      _gameController!.startFloating();
    }
  }

  /// Lida com o fim do toque na tela.
  void _handleTapUp(TapUpDetails details) => _gameController?.stopFloating();

  @override
  Widget build(BuildContext context) {
    if (_gameController == null) {
      // Mostra um indicador de carregamento enquanto o jogo é inicializado.
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final config = _gameController!.config;
    final gameAreaHeight =
        config.screenHeight * 0.6; // Define a altura da área de jogo.

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroud.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        // GestureDetector ocupa a tela inteira para capturar toques em qualquer lugar.
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          behavior: HitTestBehavior.opaque,
          // AnimatedBuilder reconstrói apenas a UI do jogo a cada "tick", otimizando a performance.
          child: AnimatedBuilder(
            animation: _gameController!,
            builder: (context, child) {
              // Stack permite sobrepor os elementos do jogo (chão, dino, cactos, UI).
              return Stack(
                children: [
                  // A área principal do jogo.
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: gameAreaHeight,
                    child: Stack(
                      children: [
                        // O jogador (dino).
                        Positioned(
                          bottom: config.groundHeight - _gameController!.dino.y,
                          left: config.dinoInitialX,
                          child: Image.asset(
                            'assets/images/perso.png',
                            width: config.dinoWidth,
                            height: config.dinoHeight,
                          ),
                        ),
                        // Os obstáculos.
                        ..._gameController!.obstacles.map((obstacle) {
                          return Positioned(
                            bottom: config.groundHeight,
                            left: obstacle.x,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/virus.png',
                                width: config.cactusWidth,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  // A UI de pontuação.
                  Positioned(
                    top: 60,
                    right: 20,
                    child: Text(
                      'PONTOS: ${_gameController!.score}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  // Overlay de "Toque para Iniciar".
                  if (!_gameController!.hasStarted)
                    const Center(
                      child: Text(
                        'Toque para Iniciar',
                        style: TextStyle(fontSize: 30, color: Colors.black54),
                      ),
                    ),
                  // Overlay de "Game Over".
                  if (_gameController!.isGameOver)
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
            },
          ),
        ),
      ),
    );
  }
}
