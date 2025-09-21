import 'package:flutter/material.dart';
import 'package:hackathon_plus/features/home/widgets/dotted_background.dart';

class HomeCheckin extends StatefulWidget {
  const HomeCheckin({super.key});

  @override
  State<HomeCheckin> createState() => _HomeCheckinState();
}

class _HomeCheckinState extends State<HomeCheckin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              width: double.infinity,
              height: 130,
              padding: EdgeInsets.all(16),
              color: const Color(0xFFB9E0FE),
              child: Stack(
                children: [
                  DottedBackground(
                    dotSpacing: 22,
                    dotSize: 6,
                    dotColor: Color(0xFF95D6FF),
                  ),
                  Row(
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
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0061AC),
                                ),
                              ),
                              Text(
                                'Exame admissional',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0061AC),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: RichText(
                text: TextSpan(
                  text: 'O que você vai fazer no ',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'SESI Saúde ',
                      style: TextStyle(color: Color(0xFF198155)),
                    ),
                    TextSpan(text: ' em 12/09/2025?'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/checkin.png',
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
