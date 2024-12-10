import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:filmify/widgets/custom_header.dart';
import 'package:filmify/widgets/custom_movie_card.dart';
import 'package:http/http.dart' as http;
import 'package:filmify/tmdb_api/dependencies.dart';

class Genres extends StatefulWidget {
  const Genres({super.key});

  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  Map<int, String> genreMap = {};
  Map<int, List<Map<String, dynamic>>> genreMovies = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGenresAndMovies();
  }

  Future<void> fetchGenresAndMovies() async {
    try {
      // Fetch genres
      final genreResponse = await http
          .get(Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey'));
      if (genreResponse.statusCode == 200) {
        final genreData = jsonDecode(genreResponse.body);
        final Map<int, String> genres = {
          for (var genre in genreData['genres'])
            genre['id'] as int: genre['name'] as String
        };

        // Fetch movies for each genre
        final Map<int, List<Map<String, dynamic>>> moviesByGenre = {};
        for (var genreId in genres.keys) {
          final movies = await fetchMoviesByGenre(genreId);
          movies.shuffle(); // Randomize the order of movies
          moviesByGenre[genreId] = movies.take(10).toList(); // Limit to 10
        }

        setState(() {
          genreMap = genres;
          genreMovies = moviesByGenre;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch genres');
      }
    } catch (e) {
      debugPrint('Error fetching genres and movies: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchMoviesByGenre(int genreId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genreId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      throw Exception('Failed to fetch movies for genre $genreId');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return CustomHeader(
      title: "Genres",
      hintText: "Cari Judul Film",
      content: genreMap.entries.map((entry) {
        final genreId = entry.key;
        final genreName = entry.value;
        final movies = genreMovies[genreId] ?? [];

        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: CustomMovieCard(
            title: genreName,
            movies: movies.map((movie) {
              final movieGenres = (movie['genre_ids'] as List)
                  .map((id) => genreMap[id] ?? 'Unknown')
                  .join(', ');

              return {
                'imagePath':
                    'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                'title': movie['title'],
                'genre': movieGenres, // Semua genre movie
                'rating': movie['vote_average'].toStringAsFixed(1),
              };
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
