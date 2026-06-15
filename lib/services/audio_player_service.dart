import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

/// Base URL for audio files when running on web.
/// Set this to wherever you host the MP3s (e.g. GitHub Releases).
/// Leave empty to fall back to Flutter asset loading (causes IDM prompt on web).
// jsDelivr serves files from GitHub with proper CORS headers and CDN caching.
// After pushing to GitHub, files are available at this URL immediately.
const String kAudioBaseUrl =
    'https://cdn.jsdelivr.net/gh/ahmadabdullah414/Qaida-App-@main/assets/audio';

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  factory AudioPlayerService() => _instance;
  AudioPlayerService._internal();

  AudioPlayer? _player;

  Future<void> play(String? audioFile) async {
    if (audioFile == null || audioFile.isEmpty) return;

    try {
      await _player?.stop();
      await _player?.dispose();
    } catch (_) {}

    final player = AudioPlayer();
    _player = player;

    try {
      if (kIsWeb && kAudioBaseUrl.isNotEmpty) {
        // Load from external URL — no file in zip, no IDM interception.
        await player.setUrl('$kAudioBaseUrl/$audioFile');
      } else if (kIsWeb) {
        // Fallback: load bytes from Flutter asset bundle to avoid IDM.
        final bytes = await rootBundle.load('assets/audio/$audioFile');
        await player.setAudioSource(
          BytesAudioSource(bytes.buffer.asUint8List()),
        );
      } else {
        await player.setAsset('assets/audio/$audioFile');
      }
      await player.play();
    } catch (_) {}
  }

  Future<void> playSequential(List<String> audioFiles) async {
    for (final file in audioFiles) {
      await play(file);
      // Wait for the player to finish before playing the next
      try {
        await _player?.playerStateStream.firstWhere(
          (s) => s.processingState == ProcessingState.completed,
        );
      } catch (_) {}
    }
  }

  Future<void> stop() async {
    try {
      await _player?.stop();
    } catch (_) {}
  }

  void dispose() {
    _player?.dispose();
    _player = null;
  }
}

class BytesAudioSource extends StreamAudioSource {
  final Uint8List _bytes;
  BytesAudioSource(this._bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= _bytes.length;
    return StreamAudioResponse(
      sourceLength: _bytes.length,
      contentLength: end - start,
      offset: start,
      contentType: 'audio/mpeg',
      stream: Stream.value(_bytes.sublist(start, end)),
    );
  }
}
