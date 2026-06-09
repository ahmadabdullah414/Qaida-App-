import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const String _kImageBase =
    'https://cdn.jsdelivr.net/gh/ahmadabdullah414/Qaida-App-@main/assets/images';

/// Loads an image from GitHub CDN on web, from bundled assets on native.
/// [filename] is just the file name (e.g. 'ic_sound.png').
Widget cdnImage(
  String filename, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.contain,
  Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
}) {
  final err = errorBuilder ?? (_, __, ___) => const SizedBox.shrink();
  if (kIsWeb) {
    return Image.network(
      '$_kImageBase/$filename',
      width: width,
      height: height,
      fit: fit,
      errorBuilder: err,
    );
  }
  return Image.asset(
    'assets/images/$filename',
    width: width,
    height: height,
    fit: fit,
    errorBuilder: err,
  );
}
