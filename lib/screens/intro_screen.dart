import 'package:flutter/material.dart';
import '../data/lessons_data.dart';
import '../models/lesson.dart';
import '../services/audio_player_service.dart';
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _lesson.textColor),
          onPressed: () => Navigator.of(context).pop(),
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
                          return SingleChildScrollView(
                            padding: EdgeInsets.all(r.isDesktop ? 40 : 24),
                            child: Column(
                              children: [
                                SizedBox(height: r.isDesktop ? 24 : 16),

                                // Image (optional)
                                if (section.imageFile != null) ...[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/images/${section.imageFile}',
                                      height: r.introImageHeight,
                                      fit: BoxFit.contain,
                                      errorBuilder: (_, __, ___) =>
                                          const SizedBox.shrink(),
                                    ),
                                  ),
                                  SizedBox(height: r.isDesktop ? 28 : 20),
                                ],

                                // Text bubble
                                Container(
                                  padding: EdgeInsets.all(r.isDesktop ? 28 : 20),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
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

                                SizedBox(height: r.isDesktop ? 28 : 20),

                                // Speaker button – user taps to hear audio
                                GestureDetector(
                                  onTap: () => _audio.play(section.audioFile),
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color:
                                          _lesson.textColor.withOpacity(0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.volume_up_rounded,
                                      color: _lesson.textColor,
                                      size: r.isDesktop ? 44 : 36,
                                    ),
                                  ),
                                ),
                              ],
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
                      IconButton(
                        onPressed: _currentPage > 0
                            ? () => _goToPage(_currentPage - 1)
                            : null,
                        icon: Icon(Icons.chevron_left,
                            color: _lesson.textColor,
                            size: r.isDesktop ? 40 : 32),
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
                      IconButton(
                        onPressed: _currentPage < totalPages - 1
                            ? () => _goToPage(_currentPage + 1)
                            : null,
                        icon: Icon(Icons.chevron_right,
                            color: _lesson.textColor,
                            size: r.isDesktop ? 40 : 32),
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
                    child: Text(
                      'Start Lesson',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: r.buttonTextSize,
                        fontWeight: FontWeight.bold,
                      ),
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
