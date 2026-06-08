import 'package:flutter/material.dart';
import '../data/lessons_data.dart';
import '../services/prefs_service.dart';
import 'intro_screen.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final List<bool> _completed = List.filled(39, false);

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    for (int i = 0; i < LessonsData.lessons.length; i++) {
      final done = await PrefsService.isCompleted(LessonsData.lessons[i].number);
      if (mounted) setState(() => _completed[i] = done);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    // Always single column — keeps layout clean on all screen sizes
    const int columns = 1;

    // Max content width on very wide screens
    final maxWidth = screenW >= 960 ? 960.0 : screenW;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF622698),
        title: const Text(
          'Qaida',
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF1a0030),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              // Each tile is a fixed height; aspect ratio drives that.
              // We let the tile height be ~72px by computing from tile width.
              childAspectRatio: _tileAspect(screenW, columns),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: LessonsData.lessons.length,
            itemBuilder: (context, index) => _buildItem(index),
          ),
        ),
      ),
    );
  }

  /// Single-column tiles: width / fixed-height gives the aspect ratio.
  double _tileAspect(double screenW, int columns) {
    final availableW = (screenW >= 960 ? 960.0 : screenW) - 24;
    const tileH = 72.0;
    return availableW / tileH;
  }

  /// Splits "20 Part(2)" → "20" on top, "Part(2)" below inside the badge circle.
  Widget _buildBadgeText(String number, double fontSize, Color color) {
    final spaceIdx = number.indexOf(' ');
    if (spaceIdx == -1) {
      // Simple number — single line
      return Text(
        number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Comfortaa',
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: color,
          height: 1.1,
        ),
      );
    }
    final top = number.substring(0, spaceIdx);
    final bottom = number.substring(spaceIdx + 1);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          top,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: color,
            height: 1.0,
          ),
        ),
        Text(
          bottom,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: (fontSize * 0.78).clamp(6.0, 11.0),
            color: color,
            height: 1.1,
          ),
        ),
      ],
    );
  }

  Widget _buildItem(int index) {
    final lesson = LessonsData.lessons[index];

    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => IntroScreen(lessonIndex: index)),
        );
        _loadProgress();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Tile dimensions we actually have
          final tileW = constraints.maxWidth;
          final tileH = constraints.maxHeight;

          // Circle badge: 80 % of tile height, capped at 52
          final badgeSize = (tileH * 0.80).clamp(28.0, 52.0);

          // Number font: shrink for long numbers (e.g. "21 Part(2)")
          final numChars  = lesson.number.length;
          final numFont   = numChars > 6
              ? (badgeSize * 0.28).clamp(7.0, 11.0)
              : numChars > 2
                  ? (badgeSize * 0.33).clamp(8.0, 13.0)
                  : (badgeSize * 0.40).clamp(10.0, 16.0);

          // Name font: scale with available width after badge + spacing
          final availableForName = tileW - badgeSize - 12 - 8; // badge + gaps
          // Start at 14, but shrink if tile is narrow
          final nameFont = (availableForName * 0.085).clamp(10.0, 15.0);

          // Check icon size
          final iconSize = (tileH * 0.42).clamp(16.0, 22.0);

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: (tileW * 0.04).clamp(8.0, 16.0),
              vertical: 0,
            ),
            decoration: BoxDecoration(
              color: lesson.backgroundColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Number badge ──────────────────────────────────────────
                SizedBox(
                  width: badgeSize,
                  height: badgeSize,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: _buildBadgeText(lesson.number, numFont, lesson.textColor),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // ── Lesson name ──────────────────────────────────────────
                Expanded(
                  child: Text(
                    lesson.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: nameFont,
                      fontWeight: FontWeight.w600,
                      color: lesson.textColor,
                      height: 1.3,
                    ),
                  ),
                ),

                // ── Checkmark ────────────────────────────────────────────
                if (_completed[index]) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.check_circle,
                    color: lesson.textColor,
                    size: iconSize,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
