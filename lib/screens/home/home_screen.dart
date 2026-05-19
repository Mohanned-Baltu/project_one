import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/navigation/app_routes.dart';
import '../../data/sample_recipes.dart';
import '../../models/recipe.dart';
import '../../widgets/recipe_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final recipes = sampleRecipesForLocale(Localizations.localeOf(context));
    final categories = ['all', 'breakfast', 'lunch', 'dinner', 'dessert'];
    final filtered = recipes.where((recipe) {
      final categoryMatches =
          _selectedCategory == 'all' || recipe.categoryKey == _selectedCategory;
      final query = _searchQuery.trim().toLowerCase();
      final searchMatches =
          query.isEmpty || recipe.title.toLowerCase().contains(query);
      return categoryMatches && searchMatches;
    }).toList();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          expandedHeight: 108,
          titleSpacing: 20,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.tr('helloChef'),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                l10n.tr('whatToCookToday'),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: l10n.tr('searchRecipes'),
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                        icon: const Icon(Icons.close_rounded),
                      )
                    : null,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.tr('categories'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final selected = category == _selectedCategory;
                      return AnimatedScale(
                        scale: selected ? 1.02 : 1,
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                        child: ChoiceChip(
                          label: Text(l10n.tr(category)),
                          selected: selected,
                          onSelected: (_) =>
                              setState(() => _selectedCategory = category),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  l10n.tr('popularRecipes'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          sliver: filtered.isEmpty
              ? SliverToBoxAdapter(
                  child: Container(
                    height: 140,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(l10n.tr('noRecipesFound')),
                  ),
                )
              : SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.crossAxisExtent > 560;
                    return SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final recipe = filtered[index];
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: Duration(milliseconds: 320 + (index * 70)),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, 16 * (1 - value)),
                                child: child,
                              ),
                            );
                          },
                          child: RecipeCard(
                            recipe: recipe,
                            heroTagPrefix: 'hero',
                            onTap: () => _openDetails(context, recipe),
                          ),
                        );
                      }, childCount: filtered.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isWide ? 2 : 1,
                        mainAxisExtent: 262,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _openDetails(BuildContext context, Recipe recipe) {
    Navigator.pushNamed(context, AppRoutes.recipeDetails, arguments: recipe);
  }
}
