import 'package:flutter/material.dart';
import '../data/lessons_data.dart';
import '../models/lesson.dart';
import '../services/audio_player_service.dart';
import '../utils/cdn_image.dart';
import '../utils/responsive.dart';
import 'lesson_screen.dart';

String _stripArabic(String text) =>
    text.replaceAll(RegExp(r'[؀-ۿݐ-ݿﭐ-﷿ﹰ-﻿]+'), '').trim();

class IntroScreen extends StatefulWidget {
  final int lessonIndex;
  const IntroScreen({super.key, required this.lessonIndex});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late final Lesson _lesson;
  final AudioPlayerService _audio = AudioPlayerService();
  int _audioIndex = 0;

  @override
  void initState() {
    super.initState();
    _lesson = LessonsData.lessons[widget.lessonIndex];
  }

  @override
  void dispose() {
    _audio.stop();
    super.dispose();
  }

  void _playAudio() {
    final sections = _lesson.introSections;
    if (sections == null || sections.isEmpty) return;
    _audio.play(sections[_audioIndex % sections.length].audioFile);
    setState(() => _audioIndex++);
  }

  @override
  Widget build(BuildContext context) {
    final r = R(context);
    final sections = _lesson.introSections;
    final hasSections = sections != null && sections.isNotEmpty;
    final isLesson1 = widget.lessonIndex == 0;

    return Scaffold(
      backgroundColor: _lesson.backgroundColor,
      appBar: AppBar(
        backgroundColor: _lesson.backgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              '←',
              style: TextStyle(
                fontSize: 22,
                color: _lesson.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Text(
          _lesson.name,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            color: _lesson.textColor,
            fontSize: r.appBarTitleSize,
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _playAudio,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: r.maxContentWidth),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: r.isDesktop ? 40 : 24,
                        vertical: r.isDesktop ? 24 : 16,
                      ),
                      child: _buildContent(r, sections, hasSections, isLesson1),
                    ),
                  ),
                ),

                // ── Start Lesson button ──────────────────────────────────
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    r.isDesktop ? 40 : 24,
                    8,
                    r.isDesktop ? 40 : 24,
                    r.isDesktop ? 32 : 24,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _audio.stop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                LessonScreen(lessonIndex: widget.lessonIndex),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _lesson.textColor,
                        foregroundColor: _lesson.backgroundColor,
                        padding: EdgeInsets.symmetric(
                            vertical: r.isDesktop ? 18 : 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cdnImage(
                            'ic_next_page.png',
                            width: r.isDesktop ? 34 : 28,
                            height: r.isDesktop ? 34 : 28,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Start Lesson',
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: r.buttonTextSize,
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
        ),
      ),
    );
  }

  Widget _buildContent(R r, List? sections, bool hasSections, bool isLesson1) {
    if (!hasSections) {
      return Text(
        _lesson.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: r.introTextSize + 4,
          color: _lesson.textColor,
        ),
      );
    }

    final items = <Widget>[];

    if (isLesson1) {
      items.add(cdnImage(
        'ic_molvi.png',
        height: r.introImageHeight,
        fit: BoxFit.contain,
      ));
      items.add(SizedBox(height: r.isDesktop ? 16 : 12));
    }

    for (final section in sections!) {
      if (!isLesson1 && section.imageFile != null) {
        items.add(Container(
          width: r.introImageHeight,
          height: r.introImageHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: cdnImage(
                section.imageFile!,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ));
        items.add(SizedBox(height: r.isDesktop ? 10 : 6));
      }
      items.add(Container(
        width: double.infinity,
        padding: EdgeInsets.all(r.isDesktop ? 20 : 14),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          _stripArabic(section.text),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: r.introTextSize,
            color: _lesson.textColor,
            height: 1.7,
          ),
        ),
      ));
      items.add(SizedBox(height: r.isDesktop ? 16 : 10));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items,
    );
  }
}
