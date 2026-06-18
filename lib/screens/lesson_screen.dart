import 'package:flutter/material.dart';
import '../data/lessons_data.dart';
import '../data/lesson_characters.dart';
import '../data/lesson_characters2.dart';
import '../data/lesson_characters3.dart';
import '../data/lesson_characters4.dart';
import '../models/character_item.dart';
import '../models/lesson.dart';
import '../services/audio_player_service.dart';
import '../services/prefs_service.dart';
import '../utils/responsive.dart';
import '../utils/cdn_image.dart';
import '../widgets/character_card.dart';
import '../widgets/ayyat_card.dart';
import '../widgets/image_character_card.dart';
import 'complete_screen.dart';

class LessonScreen extends StatefulWidget {
  final int lessonIndex;
  const LessonScreen({super.key, required this.lessonIndex});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late final Lesson _lesson;
  final AudioPlayerService _audio = AudioPlayerService();

  int _selChar  = -1;
  int _selWord  = -1;
  int _selWord2 = -1;
  int _selWord3 = -1;
  int _selImg   = -1;

  void _clearAll() {
    _selChar = _selWord = _selWord2 = _selWord3 = _selImg = -1;
  }

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

  // ── Data getters ──────────────────────────────────────────────────────────

  List<CharacterItem> get _characters {
    switch (_lesson.number) {
      case '1':  return LessonCharacters.lesson1;
      case '2':  return LessonCharacters.lesson2;
      case '3':  return LessonCharacters.lesson3;
      case '4':  return LessonCharacters4.lesson4;
      case '5':  return LessonCharacters4.lesson5;
      case '6':  return LessonCharacters.lesson6Characters;
      case '7':  return LessonCharacters.lesson7Characters;
      case '8':  return LessonCharacters.lesson8Characters;
      case '10': return LessonCharacters2.lesson10Characters;
      case '11': return LessonCharacters2.lesson11Characters;
      case '12': return LessonCharacters2.lesson12Characters;
      case '14': return LessonCharacters2.lesson14Characters;
      case '15': return LessonCharacters3.lesson15Characters;
      case '16': return LessonCharacters3.lesson16Characters;
      case '17': return LessonCharacters3.lesson17Characters;
      case '18': return LessonCharacters3.lesson18Characters;
      case '19': return LessonCharacters3.lesson19Characters;
      case '20': return LessonCharacters4.lesson20Characters;
      case '20 Part(2)': return LessonCharacters4.lesson20p2Characters;
      case '21': return LessonCharacters4.lesson21Characters;
      case '22': return LessonCharacters4.lesson22Characters;
      default:   return [];
    }
  }

  List<CharacterItem> get _words {
    switch (_lesson.number) {
      case '6':  return LessonCharacters.lesson6Words;
      case '7':  return LessonCharacters.lesson7Words;
      case '8':  return LessonCharacters.lesson8Words;
      case '9':  return LessonCharacters.lesson9Words;
      case '10': return LessonCharacters2.lesson10Words;
      case '11': return LessonCharacters2.lesson11Words;
      case '12': return LessonCharacters2.lesson12Words;
      case '13': return LessonCharacters2.lesson13Words;
      case '14': return LessonCharacters2.lesson14Words;
      case '15': return LessonCharacters3.lesson15Words;
      case '16': return LessonCharacters3.lesson16Words;
      case '17': return LessonCharacters3.lesson17Words;
      case '18': return LessonCharacters3.lesson18Words;
      case '19': return LessonCharacters3.lesson19Words;
      case '20': return LessonCharacters4.lesson20Words;
      case '20 Part(2)': return LessonCharacters4.lesson20p2Words;
      case '20 Part(3)': return LessonCharacters4.lesson20p3Words;
      case '20 Part(4)': return LessonCharacters4.lesson20p4Words;
      case '21': return LessonCharacters4.lesson21Words;
      case '21 Part(2)': return LessonCharacters4.lesson21p2Words;
      case '22 Part(2)': return LessonCharacters4.lesson22p2Words;
      case '23': return LessonCharacters4.lesson23p1Words;
      case '23 (Part 2)': return LessonCharacters4.lesson23p2Words;
      case '26': return LessonCharacters4.lesson26Words;
      case '27': return LessonCharacters4.lesson27p1Words;
      case '27 (Part 2)': return LessonCharacters4.lesson27p2Words;
      case '29': return LessonCharacters4.lesson29Words;
      default:   return [];
    }
  }

  // ── Complete ──────────────────────────────────────────────────────────────

  Future<void> _complete() async {
    await PrefsService.setCompleted(_lesson.number, true);
    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CompleteScreen(lessonIndex: widget.lessonIndex),
        ),
      );
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final r = R(context);
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
              Expanded(
                child: LayoutBuilder(
                  builder: (ctx, box) => _buildContent(R(ctx)),
                ),
              ),
              _buildCompleteButton(r),
            ],
          ),
        ),
      ),
    );
  }

  // ── Complete button ────────────────────────────────────────────────────────

  Widget _buildCompleteButton(R r) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        r.isDesktop ? 32 : 16,
        8,
        r.isDesktop ? 32 : 16,
        r.isDesktop ? 24 : 16,
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _complete,
          style: ElevatedButton.styleFrom(
            backgroundColor: _lesson.textColor,
            foregroundColor: _lesson.backgroundColor,
            padding: EdgeInsets.symmetric(vertical: r.isDesktop ? 18 : 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Complete Lesson',
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: r.buttonTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // ── Content router ─────────────────────────────────────────────────────────

  Widget _buildContent(R r) {
    final num = _lesson.number;

    if (num == '28') return _buildLesson28(r);
    if (num == '30') return _buildAyyatList(LessonCharacters4.lesson30p1Ayyat, 0, r);
    if (num == '30 (Part 2)') return _buildLesson30p2(r);
    if (num == '25') return _buildLesson25(r);
    if (num == '24') return _buildLesson24(r);

    // Words-only lessons
    const wordsOnly = [
      '9', '13',
      '20 Part(3)', '20 Part(4)', '21 Part(2)', '22 Part(2)',
      '23', '23 (Part 2)', '26', '27', '27 (Part 2)', '29',
    ];
    if (wordsOnly.contains(num)) {
      final items = _words;
      if (num == '27' || num == '27 (Part 2)' || num == '29') {
        return _buildAyyatList(items, 0, r);
      }
      final cols = (num == '23' || num == '23 (Part 2)') ? 2 : r.wordCols();
      return _buildWordGrid(items, cols, _selChar, (i) {
        setState(() { _clearAll(); _selChar = i; });
        _audio.play(items[i].audioFile);
      }, r);
    }

    // Lesson 22 – chars only
    if (num == '22') {
      return _buildScrollableCharGrid(_characters, r.charCols(), r);
    }

    // Lesson 3 – Letter Positions with column headers
    if (num == '3') return _buildLesson3(r);

    // Lessons 1-5
    if (['1', '2', '3', '4', '5'].contains(num)) {
      final cols = num == '5' ? 3 : r.charCols();
      return _buildScrollableCharGrid(_characters, cols, r);
    }

    // Lessons 6-21 Part(2): chars + words
    final chars = _characters;
    final words = _words;
    if (chars.isEmpty && words.isEmpty) {
      return const Center(child: Text('No content'));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          if (chars.isNotEmpty) ...[
            const SizedBox(height: 8),
            _charGridWidget(chars, r),
          ],
          if (words.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
              child: Divider(color: _lesson.textColor.withOpacity(0.3)),
            ),
            _wordGridWidget(words, r),
          ],
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── Grid helpers ───────────────────────────────────────────────────────────

  Widget _buildScrollableCharGrid(List<CharacterItem> items, int cols, R r) {
    return SingleChildScrollView(
      child: Padding(
        padding: r.gridPadding,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: r.charAspect,
            ),
            itemCount: items.length,
            itemBuilder: (ctx, i) {
              final item = items[i];
              if (item.imageFile != null) {
                return ImageCharacterCard(
                  item: item,
                  isSelected: _selChar == i,
                  compact: true,
                  onTap: () {
                    setState(() { _clearAll(); _selChar = i; });
                    _audio.play(item.audioFile);
                  },
                );
              }
              return CharacterCard(
                item: item,
                isSelected: _selChar == i,
                onTap: () {
                  setState(() { _clearAll(); _selChar = i; });
                  _audio.play(item.audioFile);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _charGridWidget(List<CharacterItem> items, R r) {
    return Padding(
      padding: r.gridPadding,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: r.charCols(),
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            childAspectRatio: r.charAspect,
          ),
          itemCount: items.length,
          itemBuilder: (ctx, i) => CharacterCard(
            item: items[i],
            isSelected: _selChar == i,
            onTap: () {
              setState(() { _clearAll(); _selChar = i; });
              _audio.play(items[i].audioFile);
            },
          ),
        ),
      ),
    );
  }

  Widget _wordGridWidget(List<CharacterItem> items, R r) {
    return Padding(
      padding: r.gridPadding,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: r.wordCols(),
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            childAspectRatio: r.wordAspect,
          ),
          itemCount: items.length,
          itemBuilder: (ctx, i) {
            final item = items[i];
            if (item.imageFile != null) {
              return ImageCharacterCard(
                item: item,
                isSelected: _selWord == i,
                compact: true,
                onTap: () {
                  setState(() { _clearAll(); _selWord = i; });
                  _audio.play(item.audioFile);
                },
              );
            }
            return CharacterCard(
              item: item,
              isWord: true,
              isSelected: _selWord == i,
              onTap: () {
                setState(() { _clearAll(); _selWord = i; });
                _audio.play(item.audioFile);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildWordGrid(
    List<CharacterItem> items,
    int cols,
    int selectedIndex,
    void Function(int) onTap,
    R r,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: r.gridPadding,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: r.wordAspect,
            ),
            itemCount: items.length,
            itemBuilder: (ctx, i) {
              final item = items[i];
              if (item.imageFile != null) {
                return ImageCharacterCard(
                  item: item,
                  isSelected: selectedIndex == i,
                  compact: true,
                  onTap: () => onTap(i),
                );
              }
              return CharacterCard(
                item: item,
                isWord: true,
                isSelected: selectedIndex == i,
                onTap: () => onTap(i),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImageGrid(
    List<CharacterItem> items,
    int cols,
    int selectedIndex,
    void Function(int) onTap,
    R r,
  ) {
    return Padding(
      padding: r.gridPadding,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: r.wordAspect,
          ),
          itemCount: items.length,
          itemBuilder: (ctx, i) => ImageCharacterCard(
            item: items[i],
            isSelected: selectedIndex == i,
            onTap: () => onTap(i),
          ),
        ),
      ),
    );
  }

  Widget _buildAyyatList(List<CharacterItem> items, int offset, R r) {
    if (r.isDesktop) {
      // Two-column layout on desktop
      return ListView.builder(
        padding: EdgeInsets.all(r.isDesktop ? 16 : 8),
        itemCount: (items.length / 2).ceil(),
        itemBuilder: (ctx, row) {
          final left  = row * 2;
          final right = left + 1;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ayyatOrImageCard(items[left], left + offset, offset, items),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: right < items.length
                    ? _ayyatOrImageCard(items[right], right + offset, offset, items)
                    : const SizedBox(),
              ),
            ],
          );
        },
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: items.length,
      itemBuilder: (ctx, i) => _ayyatOrImageCard(items[i], i + offset, offset, items),
    );
  }

  Widget _ayyatOrImageCard(CharacterItem item, int selIdx, int offset, List<CharacterItem> items) {
    final r = R(context);
    if (item.imageFile != null) {
      return ImageCharacterCard(
        item: item,
        isSelected: _selChar == selIdx,
        compact: false,
        onTap: () {
          setState(() { _clearAll(); _selChar = selIdx; });
          _audio.play(item.audioFile);
        },
      );
    }
    final maxScale = items
        .where((e) => e.imageFile != null)
        .map((e) => e.imageScale)
        .fold(0.0, (a, b) => a > b ? a : b);
    final minH = maxScale > 0 ? r.arabicAyyatSize * maxScale + 12 : 0.0;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minH),
      child: AyyatCard(
        item: item,
        isSelected: _selChar == selIdx,
        onTap: () {
          setState(() { _clearAll(); _selChar = selIdx; });
          _audio.play(item.audioFile);
        },
      ),
    );
  }

  Widget _buildSectionLabel(String label, R r) {
    return Padding(
      padding: EdgeInsets.fromLTRB(r.isDesktop ? 16 : 12, 12, 12, 4),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: r.labelSize,
          fontWeight: FontWeight.w600,
          color: _lesson.textColor.withOpacity(0.85),
        ),
      ),
    );
  }

  // ── Lesson 3 – Letter Positions ───────────────────────────────────────────

  Widget _buildLesson3(R r) {
    final items = _characters;
    final cols = r.isDesktop ? 8 : 4;
    const labels4 = ['End', 'Middle', 'Beginning', 'Alone'];
    final headers = r.isDesktop ? [...labels4, ...labels4] : labels4;

    return SingleChildScrollView(
      child: Padding(
        padding: r.gridPadding,
        child: Column(
          children: [
            // Column headers
            Row(
              children: headers.map((h) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    h,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: r.labelSize,
                      fontWeight: FontWeight.bold,
                      color: _lesson.textColor,
                    ),
                  ),
                ),
              )).toList(),
            ),
            // Grid
            Directionality(
              textDirection: TextDirection.rtl,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: r.charAspect,
                ),
                itemCount: items.length,
                itemBuilder: (ctx, i) {
                  final item = items[i];
                  if (item.imageFile != null) {
                    return ImageCharacterCard(
                      item: item,
                      isSelected: _selChar == i,
                      compact: true,
                      onTap: () {
                        setState(() { _clearAll(); _selChar = i; });
                        _audio.play(item.audioFile);
                      },
                    );
                  }
                  return CharacterCard(
                    item: item,
                    isSelected: _selChar == i,
                    onTap: () {
                      setState(() { _clearAll(); _selChar = i; });
                      _audio.play(item.audioFile);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Lesson 24 ──────────────────────────────────────────────────────────────

  Widget _buildLesson24(R r) {
    final w1 = LessonCharacters4.lesson24Words1;
    final w2 = LessonCharacters4.lesson24Words2;
    final w3 = LessonCharacters4.lesson24Words3;
    final w4 = LessonCharacters4.lesson24Words4;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionLabel('Tanween + Noon', r),
          Padding(
            padding: r.gridPadding,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: r.wordCols(),
                  crossAxisSpacing: 6, mainAxisSpacing: 6,
                  childAspectRatio: r.wordAspect,
                ),
                itemCount: w1.length,
                itemBuilder: (ctx, i) => CharacterCard(
                  item: w1[i], isWord: true,
                  isSelected: _selChar == i,
                  onTap: () {
                    setState(() { _clearAll(); _selChar = i; });
                    _audio.play(w1[i].audioFile);
                  },
                ),
              ),
            ),
          ),

          _buildSectionLabel('Noon Sakin', r),
          _buildWordGrid(w2, r.wordCols(), _selWord, (i) {
            setState(() { _clearAll(); _selWord = i; });
            _audio.play(w2[i].audioFile);
          }, r),

          _buildSectionLabel('Noon + Ba (IqLab)', r),
          _buildImageGrid(w3, r.wordCols(), _selWord2, (i) {
            setState(() { _clearAll(); _selWord2 = i; });
            _audio.play(w3[i].audioFile);
          }, r),

          _buildSectionLabel('Idghaam Connection', r),
          _buildImageGrid(w4, r.wordCols(), _selWord3, (i) {
            setState(() { _clearAll(); _selWord3 = i; });
            _audio.play(w4[i].audioFile);
          }, r),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── Lesson 25 ──────────────────────────────────────────────────────────────

  Widget _buildLesson25(R r) {
    final w1 = LessonCharacters4.lesson25Words1;
    final w2 = LessonCharacters4.lesson25Words2;
    final w3 = LessonCharacters4.lesson25Words3;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionLabel('Silent Letters', r),
          _buildWordGrid(w1, r.wordCols(), _selChar, (i) {
            setState(() { _clearAll(); _selChar = i; });
            _audio.play(w1[i].audioFile);
          }, r),

          _buildSectionLabel('Silent Alif (Ana)', r),
          _buildWordGrid(w2, r.wordCols(), _selWord, (i) {
            setState(() { _clearAll(); _selWord = i; });
            _audio.play(w2[i].audioFile);
          }, r),

          _buildSectionLabel('Examples', r),
          _buildWordGrid(w3, r.wordCols(), _selWord2, (i) {
            setState(() { _clearAll(); _selWord2 = i; });
            _audio.play(w3[i].audioFile);
          }, r),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── Lesson 28 ──────────────────────────────────────────────────────────────

  Widget _buildLesson28(R r) {
    final images = LessonCharacters4.lesson28Images;
    return ListView.builder(
      padding: EdgeInsets.all(r.isDesktop ? 20 : 12),
      itemCount: images.length,
      itemBuilder: (ctx, i) {
        final entry = images[i];
        final isSel = _selImg == i;
        final audios = (entry['audios'] as List).cast<String>();
        return GestureDetector(
          onTap: () {
            setState(() { _clearAll(); _selImg = i; });
            _audio.playSequential(audios);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: isSel
                  ? Border.all(color: const Color(0xFFFDE302), width: 3)
                  : Border.all(color: Colors.grey.shade200, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/${entry['image'] as String}',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                height: 80,
                color: Colors.grey.shade100,
                child: const Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ),
          ),
        );
      },
    );
  }

  // ── Lesson 30 Part 2 ───────────────────────────────────────────────────────

  Widget _buildLesson30p2(R r) {
    final kafirun = LessonCharacters4.lesson30p2SurahKafirun;
    final ikhlas  = LessonCharacters4.lesson30p2SurahIkhlas;

    Widget header(String t) => Padding(
      padding: EdgeInsets.fromLTRB(r.isDesktop ? 16 : 12, 16, 12, 4),
      child: Text(
        t,
        style: TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: r.labelSize + 1,
          fontWeight: FontWeight.bold,
          color: _lesson.textColor,
        ),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header('Surah Al-Kafirun'),
          ...kafirun.asMap().entries.map((e) => AyyatCard(
            item: e.value,
            isSelected: _selChar == e.key,
            onTap: () {
              setState(() { _clearAll(); _selChar = e.key; });
              _audio.play(e.value.audioFile);
            },
          )),
          header('Surah Al-Ikhlas'),
          ...ikhlas.asMap().entries.map((e) => AyyatCard(
            item: e.value,
            isSelected: _selWord == e.key,
            onTap: () {
              setState(() { _clearAll(); _selWord = e.key; });
              _audio.play(e.value.audioFile);
            },
          )),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
