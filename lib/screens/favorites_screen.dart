import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/favorites_provider.dart';
import 'home_screen.dart'; // To reuse GameCard

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favorites'.tr()),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, provider, child) {
          if (provider.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 100, color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)),
                  const SizedBox(height: 16),
                  Text('no_favorites'.tr(), style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return GameCard(game: provider.favorites[index]);
            },
          );
        },
      ),
    );
  }
}
