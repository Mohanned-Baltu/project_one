import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the application theme mode (light or dark) and persists it locally.
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  final String key = "theme_mode";
  late SharedPreferences _prefs;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadFromPrefs();
  }

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  /// Toggles the theme between light and dark modes.
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadFromPrefs() async {
    await _initPrefs();
    _isDarkMode = _prefs.getBool(key) ?? false;
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _isDarkMode);
  }
}
