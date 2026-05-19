class Recipe {
  const Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.durationMinutes,
    required this.rating,
    required this.categoryKey,
    required this.description,
    required this.ingredients,
    required this.steps,
  });

  final String id;
  final String title;
  final String imageUrl;
  final int durationMinutes;
  final double rating;
  final String categoryKey;
  final String description;
  final List<String> ingredients;
  final List<String> steps;
}
