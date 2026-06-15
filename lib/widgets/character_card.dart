import 'package:flutter/material.dart';
import '../models/character_item.dart';
import '../utils/responsive.dart';

class CharacterCard extends StatelessWidget {
  final CharacterItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final bool isWord; // word cards use smaller text

  const CharacterCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    this.backgroundColor,
    this.isWord = false,
  });

  @override
  Widget build(BuildContext context) {
    final r = R(context);
    const String fontFamily = 'MuhammadMusaAlBazi';
    final Color cardColor =
        isSelected ? const Color(0xFFFDE302) : (backgroundColor ?? Colors.white);
    final double fontSize = isWord ? r.arabicWordSize : r.arabicCharSize;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          border: isSelected
              ? Border.all(color: const Color(0xFFe0b800), width: 2)
              : null,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: _buildText(fontFamily, fontSize),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(String fontFamily, double fontSize) {
    final name = item.name ?? '';
    if (item.highlightIndexes != null && item.highlightIndexes!.isNotEmpty) {
      return _buildHighlightedText(name, fontFamily, fontSize);
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildHighlightedText(String text, String fontFamily, double fontSize) {
    final highlights = item.highlightIndexes!;
    final List<TextSpan> spans = [];
    int i = 0;
    while (i < text.length) {
      final isHighlighted = highlights.contains(i);
      int j = i + 1;
      while (j < text.length && highlights.contains(j) == isHighlighted) {
        j++;
      }
      spans.add(TextSpan(
        text: text.substring(i, j),
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: isHighlighted ? const Color(0xFFcc8800) : Colors.black87,
          fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
        ),
      ));
      i = j;
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: spans),
      ),
    );
  }
}
