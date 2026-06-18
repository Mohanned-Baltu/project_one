import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/favorites_provider.dart';
import '../providers/currency_provider.dart';
import '../widgets/currency_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favorites'.tr()),
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: Text(
                    '${provider.favorites.length}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: Consumer2<FavoritesProvider, CurrencyProvider>(
        builder: (context, favProvider, currProvider, child) {
          if (favProvider.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('no_favorites'.tr(), style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 700) {
                return GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 1000 ? 3 : 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: favProvider.favorites.length,
                  itemBuilder: (context, index) {
                    final favorite = favProvider.favorites[index];
                    final updatedCurrency = currProvider.currencies.firstWhere(
                      (c) => c.code == favorite.code,
                      orElse: () => favorite,
                    );
                    return CurrencyCard(
                      currency: updatedCurrency,
                      lastUpdate: currProvider.lastUpdate,
                    );
                  },
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: favProvider.favorites.length,
                itemBuilder: (context, index) {
                  final favorite = favProvider.favorites[index];
                  // Try to get updated rate if available
                  final updatedCurrency = currProvider.currencies.firstWhere(
                    (c) => c.code == favorite.code,
                    orElse: () => favorite,
                  );

                  return CurrencyCard(
                    currency: updatedCurrency,
                    lastUpdate: currProvider.lastUpdate,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
