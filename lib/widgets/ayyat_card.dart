import 'package:flutter/material.dart';
import '../models/character_item.dart';
import '../utils/responsive.dart';

class AyyatCard extends StatelessWidget {
  final CharacterItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const AyyatCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = R(context);
    const String fontFamily = 'MuhammadMusaAlBazi';
    final Color cardColor = isSelected ? const Color(0xFFFDE302) : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(
          horizontal: r.isDesktop ? 0 : 12,
          vertical: 6,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: r.isDesktop ? 20 : 16,
          vertical: r.isDesktop ? 18 : 14,
        ),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          border: isSelected
              ? Border.all(color: const Color(0xFFe0b800), width: 2)
              : Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            item.name ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: r.arabicAyyatSize,
              color: Colors.black87,
              height: 1.8,
            ),
          ),
        ),
      ),
    );
  }
}
