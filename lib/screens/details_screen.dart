import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';
import '../services/game_service.dart';
import '../models/game_details.dart';
import '../models/game.dart';
import '../providers/favorites_provider.dart';

class DetailsScreen extends StatefulWidget {
  final int gameId;
  const DetailsScreen({super.key, required this.gameId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final GameService _gameService = GameService();
  late Future<GameDetails> _gameDetailsFuture;

  @override
  void initState() {
    super.initState();
    _gameDetailsFuture = _gameService.getGameDetails(widget.gameId);
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('could_not_launch'.tr())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GameDetails>(
        future: _gameDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('\${tr("error")}: \${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('no_data'.tr()));
          }

          final game = snapshot.data!;
          // Create a mock Game object for Favorites compatibility
          final gameModel = Game(
            id: game.id,
            title: game.title,
            thumbnail: game.thumbnail,
            shortDescription: game.shortDescription,
            gameUrl: game.gameUrl,
            genre: game.genre,
            platform: game.platform,
            publisher: game.publisher,
            developer: game.developer,
            releaseDate: game.releaseDate,
            profileUrl: game.profileUrl,
          );

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(game.title, style: const TextStyle(shadows: [Shadow(color: Colors.black, blurRadius: 4)])),
                  background: Image.network(
                    game.thumbnail,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const ColoredBox(color: Colors.grey),
                  ),
                ),
                actions: [
                  Consumer<FavoritesProvider>(
                    builder: (context, provider, child) {
                      final isFav = provider.isFavorite(game.id);
                      return IconButton(
                        icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                        color: isFav ? Colors.red : Colors.white,
                        onPressed: () => provider.toggleFavorite(gameModel),
                      );
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: [
                          Chip(label: Text(game.genre)),
                          Chip(label: Text(game.platform)),
                          Chip(label: Text(game.status)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow('developer'.tr(), game.developer),
                      _buildInfoRow('publisher'.tr(), game.publisher),
                      _buildInfoRow('release_date'.tr(), game.releaseDate),
                      const SizedBox(height: 16),
                      Text('description'.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(game.description, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                          onPressed: () => _launchUrl(game.gameUrl),
                          child: Text('play_now'.tr()),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
