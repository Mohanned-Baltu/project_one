class GameDetails {
  final int id;
  final String title;
  final String thumbnail;
  final String status;
  final String shortDescription;
  final String description;
  final String gameUrl;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final String releaseDate;
  final String profileUrl;

  GameDetails({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.status,
    required this.shortDescription,
    required this.description,
    required this.gameUrl,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.profileUrl,
  });

  factory GameDetails.fromJson(Map<String, dynamic> json) {
    return GameDetails(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      status: json['status'] ?? '',
      shortDescription: json['short_description'] ?? '',
      description: json['description'] ?? '',
      gameUrl: json['game_url'] ?? '',
      genre: json['genre'] ?? '',
      platform: json['platform'] ?? '',
      publisher: json['publisher'] ?? '',
      developer: json['developer'] ?? '',
      releaseDate: json['release_date'] ?? '',
      profileUrl: json['freetogame_profile_url'] ?? '',
    );
  }
}
