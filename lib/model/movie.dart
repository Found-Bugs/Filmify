class Movie {
  bool adult;
  String backdrop_path;
  List<int> genre_ids;
  List<String>? genres; // Tambahkan ini
  int id;
  String originalTitle;
  String overview;
  String posterPath;
  String title;
  String releaseDate;
  double voteAverage;

  Movie({
    required this.adult,
    required this.backdrop_path,
    required this.genre_ids,
    this.genres,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
  });

  // Factory constructor untuk parsing JSON
  factory Movie.fromJson(Map<String, dynamic> json, Map<int, String> genreMap) {
    return Movie(
      adult: json['adult'],
      backdrop_path: json['backdrop_path'] ?? '',
      genre_ids: List<int>.from(json['genre_ids'] ?? []),
      genres: (json['genre_ids'] as List?)?.map((id) => genreMap[id] ?? 'Unknown').toList(),
      id: json['id'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      title: json['title'],
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
    );
  }
}
