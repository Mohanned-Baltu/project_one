import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/currency.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Currency> _favorites = [];
  final String key = "favorites_list";
  late SharedPreferences _prefs;

  List<Currency> get favorites => _favorites;

  FavoritesProvider() {
    _loadFromPrefs();
  }

  bool isFavorite(String code) {
    return _favorites.any((c) => c.code == code);
  }

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
      List<dynamic> jsonList = json.decode(favString);
      _favorites = jsonList.map((json) => Currency.fromCacheJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveToPrefs() async {
    await _initPrefs();
    List<Map<String, dynamic>> jsonList = _favorites.map((c) => c.toJson()).toList();
    _prefs.setString(key, json.encode(jsonList));
  }
}
