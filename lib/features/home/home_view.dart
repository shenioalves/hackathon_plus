import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hackathon_plus/features/home/widgets/dotted_background.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TransformationController _controller = TransformationController();

  // tamanho do conteúdo
  final double size = 2000;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;

      final offsetX = (screenSize.width - size) / 2;
      final offsetY = (screenSize.height - size) / 2;

      // ignore: deprecated_member_use
      _controller.value = Matrix4.identity()..translate(offsetX, offsetY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.value =
              Matrix4.identity()
                // ignore: deprecated_member_use
                ..translate(
                  (MediaQuery.of(context).size.width - size) / 2,
                  (MediaQuery.of(context).size.height - size) / 2,
                );
        },
        backgroundColor: const Color(0xFF0061AC),
        child: const Icon(Icons.center_focus_strong, color: Color(0xFFFFFFFF)),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            width: double.infinity,
            height: 130,
            padding: EdgeInsets.all(16),
            color: const Color(0xFFB9E0FE),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 6,
                  height: double.infinity,
                  color: Color(0xFF4CD471),
                ),

                SizedBox(width: 16),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 130 - 32,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Olá, João Silva',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0061AC),
                          ),
                        ),
                        Text(
                          'Exame admissional',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0061AC),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFECFCE5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'A previsão de conclusão \né de ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF198155),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '55 minutos',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),
                Container(
                  height: 130 - 32,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          Expanded(
            child: InteractiveViewer(
              transformationController: _controller,
              constrained: false,
              panEnabled: true,
              scaleEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: SizedBox(
                width: size,
                height: size,
                child: Stack(
                  children: [
                    DottedBackground(dotSpacing: 32, dotSize: 6),

                    Positioned(
                      bottom: size / 2 - 150,
                      left: size / 2 - 20,
                      child: Container(
                        width: 40,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.teal.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),

                    Positioned(
                      left: (size / 2) + 40,
                      bottom: (size / 2) + 420,
                      child: Transform.rotate(
                        angle: -math.pi / 3.8,
                        child: SizedBox(
                          width: 100,
                          height: 30,
                          child: Row(
                            children: [
                              ...List.generate(
                                10,
                                (index) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3),
                                  width: 2.5,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Color(
                                      0xFF72777A,
                                    ).withValues(alpha: 0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: (size / 2) + 40,
                      bottom: (size / 2) + 280,
                      child: Transform.rotate(
                        angle: math.pi / 3.5,
                        child: SizedBox(
                          width: 150,
                          height: 40,
                          child: Row(
                            children: [
                              ...List.generate(
                                15,
                                (index) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3),
                                  width: 2.5,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Color(
                                      0xFF72777A,
                                    ).withValues(alpha: 0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: (size / 2) - 10,
                      bottom: (size / 2) + 150,
                      child: Transform.rotate(
                        angle: -math.pi / 4.6,
                        child: SizedBox(
                          width: 200,
                          height: 40,
                          child: Row(
                            children: [
                              ...List.generate(
                                20,
                                (index) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3),
                                  width: 2.5,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Color(
                                      0xFF72777A,
                                    ).withValues(alpha: 0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: (size / 2) + 330,
                      right: (size / 2) - 100,
                      child: Image.asset(
                        'assets/images/cicle_pulmao.png',
                        width: 90,
                        height: 90,
                      ),
                    ),

                    Positioned(
                      bottom: (size / 2) + 150,
                      right: (size / 2) - 240,
                      child: Image.asset(
                        'assets/images/cicle_raiox.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                    Positioned(
                      bottom: size / 2,
                      left: size / 2 - 75,
                      child: Image.asset(
                        'assets/images/cicle_sala.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                    Positioned(
                      bottom: size / 2 - 200,
                      left: size / 2 - 90,
                      child: Image.asset(
                        'assets/images/cicle_check.png',
                        width: 180,
                        height: 180,
                      ),
                    ),

                    Positioned(
                      bottom: size / 2 + 40,
                      left: size / 2 - 205,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 4,
                          bottom: 4,
                          right: 16,
                          left: 8,
                        ),
                        child: CustomPaint(
                          painter: ChatBubblePainter(
                            color: Colors.white,
                            borderColor: Color(0xFFADADAD),
                            isSender: true,
                          ),
                          child: Container(
                            width: 165,
                            height: 80,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                              right: 10,
                              left: 4,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Você está aqui',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF404446),
                                  ),
                                ),
                                Text(
                                  'Área de espera',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF979C9E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: size / 2 + 160,
                      left: size / 2 - 170,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 4,
                          bottom: 4,
                          right: 16,
                          left: 8,
                        ),
                        child: CustomPaint(
                          painter: ChatBubblePainter(
                            color: Colors.white,
                            borderColor: Color(0xFF004F8C),
                            isSender: true,
                          ),
                          child: Container(
                            // width: 250,
                            height: 150,
                            padding: const EdgeInsets.only(
                              left: 12,
                              bottom: 12,
                              right: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Seu próximo atendimento',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF004F8C),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //SizedBox(width: 8),
                                    Image.asset(
                                      'assets/images/raiox2.png',
                                      width: 24,
                                      height: 28,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'RAIO X',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF004F8C),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //  SizedBox(width: 8),
                                    Icon(
                                      Icons.pin_drop,
                                      size: 22,
                                      color: Color(0xFF004F8C),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Sala Técnica • 2º andar',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF404446),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Previsão 17 min',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF23C16B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubblePainter extends CustomPainter {
  final Color color;
  final double arrowSize;
  final double borderRadius;
  final bool isSender;
  final Color? borderColor; // Novo: Cor da borda, opcional
  final double borderWidth; // Novo: Largura da borda

  ChatBubblePainter({
    required this.color,
    this.arrowSize = 10.0,
    this.borderRadius = 12.0,
    this.isSender = true,
    this.borderColor, // Adicione ao construtor
    this.borderWidth = 1.0, // Adicione ao construtor
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Desenha o preenchimento da bolha
    final fillPaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    // Define o caminho da bolha
    final path = isSender ? _getSenderPath(size) : _getReceiverPath(size);

    canvas.drawPath(path, fillPaint);

    // Novo: Desenha a borda se a cor for fornecida
    if (borderColor != null) {
      final borderPaint =
          Paint()
            ..color = borderColor!
            ..style = PaintingStyle.stroke
            ..strokeWidth = borderWidth;

      canvas.drawPath(path, borderPaint);
    }
  }

  Path _getSenderPath(Size size) {
    // Código anterior para o caminho do remetente...
    final rect = Rect.fromLTRB(0, 0, size.width - arrowSize, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final path = Path();
    path.addRRect(rrect);

    final arrowTip = Offset(size.width, size.height * 0.5);
    final arrowBaseTop = Offset(
      size.width - arrowSize,
      (size.height * 0.5) - arrowSize,
    );
    final arrowBaseBottom = Offset(
      size.width - arrowSize,
      (size.height * 0.5) + arrowSize,
    );

    path.moveTo(arrowBaseTop.dx, arrowBaseTop.dy);
    path.lineTo(arrowTip.dx, arrowTip.dy);
    path.lineTo(arrowBaseBottom.dx, arrowBaseBottom.dy);
    path.close();

    return path;
  }

  Path _getReceiverPath(Size size) {
    // Código anterior para o caminho do receptor...
    final rect = Rect.fromLTRB(arrowSize, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final path = Path();
    path.addRRect(rrect);

    final arrowTip = Offset(0, size.height * 0.5);
    final arrowBaseTop = Offset(arrowSize, (size.height * 0.5) - arrowSize);
    final arrowBaseBottom = Offset(arrowSize, (size.height * 0.5) + arrowSize);

    path.moveTo(arrowBaseTop.dx, arrowBaseTop.dy);
    path.lineTo(arrowTip.dx, arrowTip.dy);
    path.lineTo(arrowBaseBottom.dx, arrowBaseBottom.dy);
    path.close();

    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // É importante retornar `true` se as propriedades mudarem para redesenhar a borda.
    // Ou, para otimização, cheque se as propriedades relevantes mudaram.
    return true;
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedLinePainter({
    this.color = Colors.grey,
    this.strokeWidth = 2.0,
    this.dashWidth = 10.0,
    this.dashSpace = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round; // Arredonda as pontas das linhas

    // Desenha as linhas horizontais tracejadas
    for (double i = 0; i < size.height; i += (strokeWidth + dashSpace) * 2) {
      double startX = 0;
      while (startX < size.width) {
        // Crie um ponto de início e fim para cada traço
        final p1 = Offset(startX, i);
        final p2 = Offset(math.min(startX + dashWidth, size.width), i);
        canvas.drawLine(p1, p2, paint);
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
