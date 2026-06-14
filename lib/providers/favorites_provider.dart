import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/currency.dart';

/// Manages favorite currencies and persists them locally using SharedPreferences.
class FavoritesProvider extends ChangeNotifier {
  List<Currency> _favorites = [];
  final String key = "favorites_list";
  late SharedPreferences _prefs;

  List<Currency> get favorites => _favorites;

  FavoritesProvider() {
    _loadFromPrefs();
  }

  /// Checks if a given currency code is in the favorites list.
  bool isFavorite(String code) {
    return _favorites.any((c) => c.code == code);
  }

  /// Adds or removes a currency from the favorites list.
  void toggleFavorite(Currency currency) {
    if (isFavorite(currency.code)) {
      _favorites.removeWhere((c) => c.code == currency.code);
    } else {
      _favorites.add(currency);
    }
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadFromPrefs() async {
    await _initPrefs();
    String? favString = _prefs.getString(key);
    if (favString != null) {
      try {
        List<dynamic> jsonList = json.decode(favString);
        _favorites = jsonList.map((j) {
          if (j is Map<String, dynamic>) {
            return Currency.fromCacheJson(j);
          }
          return null;
        }).where((c) => c != null).cast<Currency>().toList();
      } catch (e) {
        _favorites = [];
      }
      notifyListeners();
    }
  }

  Future<void> _saveToPrefs() async {
    await _initPrefs();
    List<Map<String, dynamic>> jsonList = _favorites.map((c) => c.toJson()).toList();
    _prefs.setString(key, json.encode(jsonList));
  }
}
