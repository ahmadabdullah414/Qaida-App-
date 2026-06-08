import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static Future<void> setCompleted(String lessonNumber, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('lesson_$lessonNumber', value);
  }

  static Future<bool> isCompleted(String lessonNumber) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('lesson_$lessonNumber') ?? false;
  }
}
