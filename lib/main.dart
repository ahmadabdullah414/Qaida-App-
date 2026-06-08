import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const QaidaApp());
}

class QaidaApp extends StatelessWidget {
  const QaidaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qaida',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF622698),
          brightness: Brightness.light,
        ),
        fontFamily: 'Comfortaa',
      ),
      home: const SplashScreen(),
    );
  }
}
