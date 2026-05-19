import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPrefs {
  static const _seenKey = 'onboarding_seen';

  static Future<bool> isSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_seenKey) ?? false;
  }

  static Future<void> markSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_seenKey, true);
  }
}
