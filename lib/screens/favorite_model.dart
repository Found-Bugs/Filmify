class FavoriteMovie {
  final String imageUrl;
  final String title;
  final String genre;
  final String rating;
  final String description;

  FavoriteMovie({
    required this.imageUrl,
    required this.title,
    required this.genre,
    required this.rating,
    required this.description,
  });

  Map<String, String> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'genre': genre,
      'rating': rating,
      'description': description,
    };
  }

  factory FavoriteMovie.fromMap(Map<String, String> map) {
    return FavoriteMovie(
      imageUrl: map['imageUrl']!,
      title: map['title']!,
      genre: map['genre']!,
      rating: map['rating']!,
      description: map['description']!,
    );
  }
}
