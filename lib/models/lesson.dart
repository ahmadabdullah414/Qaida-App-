import 'package:flutter/material.dart';
import 'intro_section.dart';

class Lesson {
  final String number;
  final String name;
  final List<IntroSection>? introSections;
  final Color backgroundColor;
  final Color textColor;
  final String? character;

  const Lesson({
    required this.number,
    required this.name,
    this.introSections,
    required this.backgroundColor,
    required this.textColor,
    this.character,
  });
}
