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
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _searchQuery = '';

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

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredGenreMovies = genreMovies.map((genreId, movies) {
      final filteredMovies = movies.where((movie) {
        final title = movie['title'].toLowerCase();
        return title.contains(_searchQuery);
      }).toList();
      return MapEntry(genreId, filteredMovies);
    });

    // Filter out genres with no matching movies
    final filteredGenres = filteredGenreMovies.entries
        .where((entry) => entry.value.isNotEmpty)
        .toList();

    // Sort genres to bring those with matching movies to the top
    filteredGenres.sort((a, b) {
      final aHasMatch = a.value.isNotEmpty;
      final bHasMatch = b.value.isNotEmpty;
      if (aHasMatch && !bHasMatch) return -1;
      if (!aHasMatch && bHasMatch) return 1;
      return 0;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Genres'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search movies title',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: _onSearchChanged,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: filteredGenres.map((entry) {
                  final genreId = entry.key;
                  final genreName = genreMap[genreId]!;
                  final movies = entry.value;

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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
