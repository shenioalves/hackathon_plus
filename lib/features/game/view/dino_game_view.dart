import 'package:flutter/material.dart';
import 'package:hackathon_plus/features/game/controller/game_controller.dart';
// Verifique se estes caminhos de importação correspondem à sua estrutura de projeto.
import '../controller/gamer_config.dart';
import 'widgets/game_area.dart';
import 'widgets/ui_overlay.dart';

/// O StatefulWidget principal que gerencia o estado da tela do jogo.
class DinoGameScreen extends StatefulWidget {
  const DinoGameScreen({super.key});
  @override
  State<DinoGameScreen> createState() => _DinoGameScreenState();
}

/// A classe de estado que gerencia o ciclo de vida e a construção da UI do jogo.
class _DinoGameScreenState extends State<DinoGameScreen>
    with SingleTickerProviderStateMixin {
  GameController? _gameController;
  GameConfig? _gameConfig;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Inicializa as configurações e o controller do jogo apenas uma vez.
    if (_gameConfig == null) {
      final size = MediaQuery.of(context).size;
      setState(() {
        _gameConfig = GameConfig(
          screenWidth: size.width,
          screenHeight: size.height,
        );
        _gameController = GameController(config: _gameConfig!, vsync: this);
      });
    }
  }

  @override
  void dispose() {
    // Libera os recursos do controller para evitar vazamento de memória.
    _gameController?.dispose();
    super.dispose();
  }

  /// Lida com o início do toque na tela, seja para iniciar, reiniciar ou pular.
  void _handleTapDown(TapDownDetails details) {
    if (_gameController == null) return;
    if (_gameController!.isGameOver) {
      _gameController!.resetGame();
    } else if (!_gameController!.hasStarted) {
      _gameController!.startGame();
    } else {
      _gameController!.jump();
      _gameController!.startFloating();
    }
  }

  /// Lida com o fim do toque na tela para parar a planagem.
  //void _handleTapUp(TapDownDetails details) => _gameController?.stopFloating();

  @override
  Widget build(BuildContext context) {
    // Mostra um indicador de carregamento enquanto o jogo é inicializado.
    if (_gameConfig == null || _gameController == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: GestureDetector(
        onTapDown: _handleTapDown,
        // onTapUp: _handleTapUp,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            // Camada 1: Layout visual do jogo (Céu e Base)
            Column(
              children: [
                Expanded(
                  flex: 3,
                  // AnimatedBuilder escuta o controller e reconstrói a área de jogo.
                  child: AnimatedBuilder(
                    animation: _gameController!,
                    builder: (context, child) =>
                        GameArea(controller: _gameController!),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    "assets/images/base.png",
                    width: _gameConfig!.screenWidth,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            // Camada 2: UI (pontos, game over, etc.)
            AnimatedBuilder(
              animation: _gameController!,
              builder: (context, child) =>
                  UiOverlay(controller: _gameController!),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: SafeArea(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 130 - 32,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF0061AC),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'SUA SENHA',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                            Text(
                              'OZ-8576',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
