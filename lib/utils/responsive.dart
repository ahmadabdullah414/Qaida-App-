import 'package:flutter/material.dart';

/// Breakpoints
/// phone  : width < 600
/// tablet : 600 <= width < 960
/// desktop: width >= 960

enum DeviceType { phone, tablet, desktop }

class R {
  final double _w;
  final double _h;

  R(BuildContext context)
      : _w = MediaQuery.of(context).size.width,
        _h = MediaQuery.of(context).size.height;

  DeviceType get device {
    if (_w >= 960) return DeviceType.desktop;
    if (_w >= 600) return DeviceType.tablet;
    return DeviceType.phone;
  }

  bool get isPhone => device == DeviceType.phone;
  bool get isTablet => device == DeviceType.tablet;
  bool get isDesktop => device == DeviceType.desktop;

  double get screenWidth => _w;
  double get screenHeight => _h;

  // ── Text scales ──────────────────────────────────────────────────────────
  double get _scale {
    if (_w >= 960) return 1.45;
    if (_w >= 600) return 1.20;
    return 1.0;
  }

  double sp(double base) => base * _scale;

  // Convenience sizes
  double get arabicCharSize => sp(52);   // character grid cells
  double get arabicWordSize => sp(42);   // word grid cells
  double get arabicAyyatSize => sp(46);  // full-width ayyat rows
  double get arabicImageSize => sp(36);  // image-card text
  double get introTextSize  => sp(15);   // intro paragraph
  double get introArabicSize => sp(54);  // arabic in intro
  double get buttonTextSize  => sp(16);
  double get appBarTitleSize => sp(18);
  double get labelSize       => sp(13);
  double get lessonNumSize   => sp(13);
  double get lessonNameSize  => sp(14);

  // ── Layout ───────────────────────────────────────────────────────────────

  /// Max content width (centres content on wide screens)
  double get maxContentWidth {
    if (_w >= 960) return 900;
    return _w;
  }

  /// Character grid columns
  int charCols({int? override}) {
    if (override != null) return override;
    if (_w >= 960) return 8;
    if (_w >= 600) return 6;
    return 4;
  }

  /// Word grid columns
  int wordCols({int? override}) {
    if (override != null) return override;
    if (_w >= 960) return 5;
    if (_w >= 600) return 4;
    return 3;
  }

  /// Ayyat/stopping columns
  int ayyatCols() {
    if (_w >= 960) return 2;
    if (_w >= 600) return 2;
    return 1;
  }

  /// Grid padding
  EdgeInsets get gridPadding => EdgeInsets.symmetric(
        horizontal: _w >= 960 ? 24 : 10,
        vertical: 6,
      );

  /// Card aspect ratios
  double get charAspect => isPhone ? 0.75 : 0.85;
  double get wordAspect => isPhone ? 1.3 : 1.5;

  /// Index item height
  double get indexItemHeight => sp(52);

  /// Splash logo size
  double get splashLogoSize => _w * 0.22 < 80 ? 80 : (_w * 0.22 > 180 ? 180 : _w * 0.22);

  /// Intro image height
  double get introImageHeight {
    if (_w >= 960) return 100;
    if (_w >= 600) return 80;
    return 65;
  }

  /// Complete icon size
  double get completeIconSize => sp(60);
}
