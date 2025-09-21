import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/fundo.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/sesi.png',
                      width: screenWidth * 0.45,
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 16),
                    Image.asset(
                      'assets/images/exame.png',
                      width: screenWidth * 0.65,
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),

                Image.asset(
                  'assets/images/sergio.png',
                  width: screenWidth * 0.8,
                  fit: BoxFit.fitWidth,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home_checkin');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0061AC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 20,
                    ),
                  ),
                  child: SizedBox(
                    width: screenWidth * 0.6,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/iconn.png',
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Continuar',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}
