import 'package:flutter/material.dart';
import '../models/character_item.dart';
import '../utils/cdn_image.dart';
import '../utils/responsive.dart';

class ImageCharacterCard extends StatelessWidget {
  final CharacterItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const ImageCharacterCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = R(context);
    const String fontFamily = 'AlQalamQuran';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 6, 4, 2),
                child: cdnImage(
                  item.imageFile!,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    item.name ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: r.arabicImageSize,
                      color: Colors.black87,
                      height: 2.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
