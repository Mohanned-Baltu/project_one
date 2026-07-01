import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game.dart';
import '../models/game_details.dart';

class GameService {
  static const String baseUrl = 'https://www.freetogame.com/api';

  Future<List<Game>> getGames() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/games'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Game.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load games: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching games: $e');
    }
  }

  Future<List<Game>> getGamesByCategory(String category) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/games?category=$category'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Game.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load games by category: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching games by category: $e');
    }
  }

  Future<GameDetails> getGameDetails(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/game?id=$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return GameDetails.fromJson(data);
      } else {
        throw Exception('Failed to load game details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching game details: $e');
    }
  }
}
