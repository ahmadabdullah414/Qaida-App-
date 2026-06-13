import 'package:flutter/material.dart';
import '../models/character_item.dart';
import '../utils/cdn_image.dart';
import '../utils/responsive.dart';

class ImageCharacterCard extends StatelessWidget {
  final CharacterItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool compact;

  const ImageCharacterCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final r = R(context);
    const String fontFamily = 'MuhammadMusaAlBazi';

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFDE302) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(color: const Color(0xFFe0b800), width: 2.5)
              : Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: cdnImage(
              item.imageFile!,
              width: compact ? r.arabicWordSize * item.imageScale : null,
              height: compact ? r.arabicWordSize * item.imageScale : null,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.image_not_supported,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
