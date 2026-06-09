import 'package:flutter/material.dart';
import '../data/lessons_data.dart';
import '../models/lesson.dart';
import '../services/audio_player_service.dart';
import '../utils/cdn_image.dart';
import '../utils/responsive.dart';
import 'lesson_screen.dart';

class IntroScreen extends StatefulWidget {
  final int lessonIndex;
  const IntroScreen({super.key, required this.lessonIndex});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late final Lesson _lesson;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final AudioPlayerService _audio = AudioPlayerService();

  @override
  void initState() {
    super.initState();
    _lesson = LessonsData.lessons[widget.lessonIndex];
    // NOTE: No auto-play on init — browsers block audio before user interaction.
    // User taps the speaker icon or navigates pages to trigger audio.
  }

  @override
  void dispose() {
    _pageController.dispose();
    _audio.stop();
    super.dispose();
  }

  void _goToPage(int page) {
    final sections = _lesson.introSections;
    if (sections == null || page < 0 || page >= sections.length) return;
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _currentPage = page);
    _audio.play(sections[page].audioFile);
  }

  @override
  Widget build(BuildContext context) {
    final r = R(context);
    final sections = _lesson.introSections;
    final hasSections = sections != null && sections.isNotEmpty;
    final totalPages = hasSections ? sections.length : 0;

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
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: r.maxContentWidth),
          child: Column(
            children: [
              // ── Page content ────────────────────────────────────────────
              Expanded(
                child: hasSections
                    ? PageView.builder(
                        controller: _pageController,
                        onPageChanged: (p) {
                          setState(() => _currentPage = p);
                          _audio.play(sections[p].audioFile);
                        },
                        itemCount: totalPages,
                        itemBuilder: (context, index) {
                          final section = sections[index];
                          final isLesson1 = widget.lessonIndex == 0;
                          final speakerSize = r.isDesktop ? 90.0 : 72.0;
                          return LayoutBuilder(
                            builder: (ctx, constraints) => SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight),
                                child: IntrinsicHeight(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: r.isDesktop ? 24 : 16),

                                      // Lesson 1 only: ic_molvi.png (teacher
                                      // reading quran) — tappable to play audio
                                      if (isLesson1) ...[
                                        GestureDetector(
                                          onTap: () => _audio.play(section.audioFile),
                                          child: cdnImage(
                                            'ic_molvi.png',
                                            height: r.introImageHeight,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(height: r.isDesktop ? 16 : 12),
                                      ],

                                      // Intro image for other lessons (optional)
                                      if (!isLesson1 && section.imageFile != null) ...[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: cdnImage(
                                            section.imageFile!,
                                            height: r.introImageHeight,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(
                                            height: r.isDesktop ? 24 : 16),
                                      ],

                                      // Text bubble
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                r.isDesktop ? 40 : 24),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(
                                              r.isDesktop ? 28 : 20),
                                          decoration: BoxDecoration(
                                            color: Colors.black
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Text(
                                            section.text,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Comfortaa',
                                              fontSize: r.introTextSize,
                                              color: _lesson.textColor,
                                              height: 1.7,
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: r.isDesktop ? 24 : 16),

                                      // Speaker button — ic_sound.png (orange
                                      // circle with speaker) shown for all lessons
                                      GestureDetector(
                                        onTap: () =>
                                            _audio.play(section.audioFile),
                                        child: cdnImage(
                                          'ic_sound.png',
                                          width: speakerSize,
                                          height: speakerSize,
                                          fit: BoxFit.contain,
                                          errorBuilder: (_, __, ___) =>
                                              Container(
                                            width: speakerSize,
                                            height: speakerSize,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFFF9800),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.volume_up,
                                              color: Colors.white,
                                              size: speakerSize * 0.5,
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: r.isDesktop ? 24 : 16),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            _lesson.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: r.introTextSize + 4,
                              color: _lesson.textColor,
                            ),
                          ),
                        ),
                      ),
              ),

              // ── Page dots + arrows ────────────────────────────────────────
              if (hasSections && totalPages > 1)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _currentPage > 0
                            ? () => _goToPage(_currentPage - 1)
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Text(
                            '‹',
                            style: TextStyle(
                              fontSize: r.isDesktop ? 36 : 28,
                              color: _currentPage > 0
                                  ? _lesson.textColor
                                  : _lesson.textColor.withOpacity(0.3),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(
                        totalPages,
                        (i) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == i ? 12 : 8,
                          height: _currentPage == i ? 12 : 8,
                          decoration: BoxDecoration(
                            color: _currentPage == i
                                ? _lesson.textColor
                                : _lesson.textColor.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _currentPage < totalPages - 1
                            ? () => _goToPage(_currentPage + 1)
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Text(
                            '›',
                            style: TextStyle(
                              fontSize: r.isDesktop ? 36 : 28,
                              color: _currentPage < totalPages - 1
                                  ? _lesson.textColor
                                  : _lesson.textColor.withOpacity(0.3),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // ── Start Lesson button ────────────────────────────────────────
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
    );
  }
}
