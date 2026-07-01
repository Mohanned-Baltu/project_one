import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/game_service.dart';

class GamesProvider extends ChangeNotifier {
  final GameService _gameService = GameService();

  List<Game> _games = [];
  List<Game> _filteredGames = [];
  bool _isLoading = false;
  String? _error;
  String _selectedCategory = 'All';

  List<Game> get games => _filteredGames;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedCategory => _selectedCategory;

  final List<String> categories = [
    'All',
    'Shooter',
    'MMORPG',
    'Racing',
    'Strategy',
    'Sports',
    'Action',
    'RPG',
  ];

  GamesProvider() {
    fetchGames();
  }

  Future<void> fetchGames() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (_selectedCategory == 'All') {
        _games = await _gameService.getGames();
      } else {
        _games = await _gameService.getGamesByCategory(_selectedCategory.toLowerCase());
      }
      _filteredGames = List.from(_games);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      fetchGames();
    }
  }

  void searchGames(String query) {
    if (query.isEmpty) {
      _filteredGames = List.from(_games);
    } else {
      _filteredGames = _games
          .where((game) => game.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
