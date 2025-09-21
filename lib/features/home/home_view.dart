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
  final double contentWidth = 2000;
  final double contentHeight = 2000;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;

      final offsetX = (screenSize.width - contentWidth) / 2;
      final offsetY = (screenSize.height - contentHeight) / 4;

      _controller.value = Matrix4.identity()..translate(offsetX, offsetY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                width: 2000,
                height: 2000,
                child: Stack(
                  children: [DottedBackground(dotSpacing: 60, dotSize: 12)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
