import 'package:flutter/material.dart';
import 'index_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const IndexScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final logoSize = (w * 0.22).clamp(80.0, 180.0);
    final titleSize = (w * 0.08).clamp(32.0, 64.0);
    final subtitleSize = (w * 0.025).clamp(13.0, 22.0);

    return Scaffold(
      backgroundColor: const Color(0xFF622698),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage('assets/images/qurancube_logo.png'),
              width: logoSize,
              height: logoSize,
            ),
            SizedBox(height: logoSize * 0.17),
            Text(
              'Qaida',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Learn to Read the Quran',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: subtitleSize,
                color: const Color(0xFFFDE302),
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
