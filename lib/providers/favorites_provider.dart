import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game.dart';

class FavoritesProvider extends ChangeNotifier {
  static const String _favoritesKey = 'favorite_games';
  List<Game> _favorites = [];

  List<Game> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString(_favoritesKey);

    if (favoritesJson != null) {
      final List<dynamic> decodedList = json.decode(favoritesJson);
      _favorites = decodedList.map((json) => Game.fromJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = json.encode(_favorites.map((game) => game.toJson()).toList());
    await prefs.setString(_favoritesKey, encodedList);
  }

  bool isFavorite(int id) {
    return _favorites.any((game) => game.id == id);
  }

  void toggleFavorite(Game game) {
    if (isFavorite(game.id)) {
      _favorites.removeWhere((g) => g.id == game.id);
    } else {
      _favorites.add(game);
    }
    _saveFavorites();
    notifyListeners();
  }
}
