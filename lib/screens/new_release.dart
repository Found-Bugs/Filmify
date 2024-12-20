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
  Map<int, String> genreMap = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNewReleases();
  }

  Future<void> fetchGenres() async {
    const String genresUrl =
        'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';

    try {
      final response = await http.get(Uri.parse(genresUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        genreMap = {
          for (var genre in data['genres']) genre['id']: genre['name']
        };
      }
    } catch (e) {
      debugPrint('Error fetching genres: $e');
    }
  }

  Future<void> fetchNewReleases() async {
    const String newReleasesUrl =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=en-US&page=1';

    try {
      // Fetch genres before movies
      await fetchGenres();

      final response = await http.get(Uri.parse(newReleasesUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          movies =
              List<Map<String, dynamic>>.from(data['results'].map((movie) => {
                    'id': movie['id'],
                    'title': movie['title'],
                    'genre': movie['genre_ids']
                        .map((id) => genreMap[id] ?? 'Unknown')
                        .join(', '),
                    'rating': movie['vote_average'].toStringAsFixed(1),
                    'description': movie['overview'],
                    'imageUrl':
                        'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                  }));
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
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
                              movieId: movie['id'],
                              imageUrl: movie['imageUrl'],
                              title: movie['title'],
                              genre: movie['genre'], // Display genre names
                              rating: movie['rating'],
                              description: movie['description'],
                              showBookmark: false, // Hide bookmark icon
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ))
                  .toList(),
    );
  }
}
