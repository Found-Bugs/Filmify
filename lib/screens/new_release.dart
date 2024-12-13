import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:filmify/widgets/custom_favorite_card.dart';
import 'package:filmify/widgets/custom_header.dart';
import 'package:filmify/tmdb_api/dependencies.dart';
import 'package:filmify/screens/detail_movie.dart';

class NewRelease extends StatefulWidget {
  const NewRelease({super.key});

  @override
  State<NewRelease> createState() => _NewReleaseState();
}

class _NewReleaseState extends State<NewRelease> {
  List<Map<String, dynamic>> movies = [];
  bool isLoading = true;
  Map<int, String> genreMap = {};

  @override
  void initState() {
    super.initState();
    fetchGenres().then((_) => fetchMovies());
  }

  Future<void> fetchGenres() async {
    const String genreUrl =
        'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';

    try {
      final response = await http.get(Uri.parse(genreUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          genreMap = {
            for (var genre in data['genres']) genre['id']: genre['name']
          };
        });
      } else {
        throw Exception('Failed to load genres');
      }
    } catch (e) {
      debugPrint('Error fetching genres: $e');
    }
  }

  Future<void> fetchMovies() async {
    const String url =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=en-US&page=1';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          movies = List<Map<String, dynamic>>.from(data['results'].map((movie) {
            final List<int> genreIds = List<int>.from(movie['genre_ids']);
            final String genres = genreIds
                .map((id) => genreMap[id] ?? 'Unknown Genre')
                .join(', '); // Map genre IDs to names

            return {
              'id': movie['id'],
              'title': movie['title'] ?? 'Unknown Title',
              'genre': genres,
              'rating': movie['vote_average'].toStringAsFixed(1),
              'description': movie['overview'] ?? 'No description available',
              'imageUrl':
                  'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
            };
          }));
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      title: "New Release",
      hintText: "Cari Judul Film",
      content: isLoading
          ? [const Center(child: CircularProgressIndicator())]
          : movies.isEmpty
              ? [const Center(child: Text("No movies available"))]
              : movies
                  .map((movie) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMovie(
                                id: movie['id'], // Pass movie ID to DetailMovie
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            CustomFavoriteCard(
                              imageUrl: movie['imageUrl'],
                              title: movie['title'],
                              genre: movie['genre'],
                              rating: movie['rating'],
                              description: movie['description'],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ))
                  .toList(),
    );
  }
}
