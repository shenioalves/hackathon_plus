import 'package:flutter/material.dart';
import 'package:hackathon_plus/features/game/view/dino_game_view.dart';
import 'package:hackathon_plus/features/home/home_view.dart';
import 'package:hackathon_plus/features/home/view/home_checkin.dart';

import 'package:hackathon_plus/features/splash/view/splash_view.dart';

void main() => runApp(const MyApp());

/// Widget raiz da aplicação.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',

      routes: {
        '/': (context) => SplashView(),
        '/home_checkin': (context) => HomeCheckin(),
        '/home': (context) => HomeView(),
        '/gamer': (context) => DinoGameScreen(),
      },
    );
  }
}
