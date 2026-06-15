import 'package:flutter/material.dart';
import '../data/lessons_data.dart';
import '../utils/cdn_image.dart';
import '../utils/responsive.dart';
import 'index_screen.dart';
import 'intro_screen.dart';

class CompleteScreen extends StatelessWidget {
  final int lessonIndex;
  const CompleteScreen({super.key, required this.lessonIndex});

  @override
  Widget build(BuildContext context) {
    final r = R(context);
    final lesson = LessonsData.lessons[lessonIndex];
    final isLast = lessonIndex >= LessonsData.lessons.length - 1;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          cdnImage(
            'bg_lesson_complete.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: const Color(0xFF622698)),
          ),
          Container(color: Colors.black.withOpacity(0.20)),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: r.isDesktop ? 600 : double.infinity),
                child: Padding(
                  padding: EdgeInsets.all(r.isDesktop ? 48 : 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Star emoji — bg_lesson_complete.png already contains
                      // the decorative image; just show a large star above text
                      Text(
                        '⭐',
                        style: TextStyle(fontSize: r.completeIconSize),
                      ),
                      SizedBox(height: r.isDesktop ? 28 : 20),
                      Text(
                        'Lesson Complete!',
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: r.sp(28),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        lesson.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: r.sp(16),
                          color: const Color(0xFFFDE302),
                        ),
                      ),
                      SizedBox(height: r.isDesktop ? 60 : 48),

                      if (!isLast) ...[
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      IntroScreen(lessonIndex: lessonIndex + 1),
                                ),
                                (route) => route.isFirst,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFDE302),
                              foregroundColor: const Color(0xFF241833),
                              padding: EdgeInsets.symmetric(
                                  vertical: r.isDesktop ? 18 : 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(
                              'Next Lesson',
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: r.buttonTextSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      if (isLast)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            'Congratulations!\nYou have completed the Qaida!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: r.sp(15),
                              color: Colors.white,
                            ),
                          ),
                        ),

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => const IndexScreen()),
                              (route) => false,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white, width: 2),
                            padding: EdgeInsets.symmetric(
                                vertical: r.isDesktop ? 18 : 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(
                            'Back to Menu',
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: r.buttonTextSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }
}
