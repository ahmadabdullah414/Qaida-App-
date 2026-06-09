import 'package:flutter/material.dart';
import '../utils/cdn_image.dart';
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
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const IndexScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final logoW = (size.width * 0.55).clamp(200.0, 420.0);
    final logoH = (size.height * 0.22).clamp(100.0, 200.0);

    return Scaffold(
      backgroundColor: const Color(0xFF4A1880),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Quran Cube logo
            cdnImage(
              'qurancube_logo.png',
              width: logoW,
              height: logoH,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Text(
                'Quran Cube',
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: (size.width * 0.07).clamp(28.0, 56.0),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: size.height * 0.06),

            // App name
            Text(
              'Qaida',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: (size.width * 0.1).clamp(36.0, 72.0),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 3,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'Learn to Read the Quran',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: (size.width * 0.03).clamp(14.0, 22.0),
                color: const Color(0xFFFDE302),
                letterSpacing: 1,
              ),
            ),

            SizedBox(height: size.height * 0.08),

            // Loading dots
            const _LoadingDots(),
          ],
        ),
      ),
    );
  }
}

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();
  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final step = (_ctrl.value * 3).floor();
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == step
                    ? const Color(0xFFFDE302)
                    : Colors.white.withOpacity(0.3),
              ),
            );
          }),
        );
      },
    );
  }
}
