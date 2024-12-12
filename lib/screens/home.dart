import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:filmify/screens/genres.dart';
import 'package:filmify/screens/cinemas.dart';
import 'package:filmify/screens/new_release.dart';
import 'package:filmify/screens/platforms.dart';
import 'package:filmify/widgets/custom_carousel.dart';
import 'package:filmify/widgets/custom_menu.dart';
import 'package:filmify/widgets/custom_movie_card.dart';
import 'package:filmify/widgets/custom_search.dart';
import 'package:flutter/material.dart';
// import 'package:filmify/data/data_movie_A.dart';
import 'package:filmify/data/data_movie_B.dart';
import 'package:filmify/tmdb_api/dependencies.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> topRatedMovies = [];
  List<Map<String, dynamic>> upcomingMovies = [];
  Map<int, String> genreMap = {};

  @override
  void initState() {
    super.initState();
    fetchGenres();
    fetchMovies();
  }

  Future<void> fetchGenres() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          genreMap = {
            for (var genre in data['genres']) genre['id']: genre['name']
          };
        });
      } else {
        throw Exception('Failed to fetch genres');
      }
    } catch (e) {
      debugPrint('Error fetching genres: $e');
    }
  }

  Future<void> fetchMovies() async {
    try {
      final topRated = await fetchFromApi('/movie/top_rated');
      final upcoming = await fetchFromApi('/movie/upcoming');

      setState(() {
        topRatedMovies = topRated.take(10).toList();
        upcomingMovies = upcoming.take(10).toList();
      });
    } catch (e) {
      debugPrint('Error fetching movies: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchFromApi(String endpoint) async {
    final response =
        await http.get(Uri.parse('$baseUrl$endpoint?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 45.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                        height: 70), // Space for the floating search bar
                    const CustomCarousel(),
                    const SizedBox(height: 20),
                    CustomMenu(
                      categories: [
                        {
                          'icon': Icons.movie,
                          'label': 'Genres',
                          'onTap': () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Genres()),
                            );
                          },
                        },
                        {
                          'icon': Icons.tv,
                          'label': 'Platforms',
                          'onTap': () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Platforms()),
                            );
                          },
                        },
                        {
                          'icon': Icons.theaters,
                          'label': 'Cinemas',
                          'onTap': () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Cinemas()),
                            );
                          },
                        },
                        {
                          'icon': Icons.new_releases,
                          'label': 'New Release',
                          'onTap': () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NewRelease()),
                            );
                          },
                        },
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomMovieCard(
                      title: 'Recommended Movies',
                      movies: topRatedMovies.map((movie) {
                        final genreNames = (movie['genre_ids'] as List)
                            .map((id) => genreMap[id] ?? 'Unknown')
                            .join(', ');
                        return {
                          'id': movie['id'],
                          'imagePath':
                              'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          'title': movie['title'],
                          'genre': genreNames,
                          'rating': movie['vote_average'].toStringAsFixed(1),
                        };
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    CustomMovieCard(
                      title: 'Upcoming Movies',
                      movies: upcomingMovies.map((movie) {
                        final genreNames = (movie['genre_ids'] as List)
                            .map((id) => genreMap[id] ?? 'Unknown')
                            .join(', ');
                        return {
                          'id': movie['id'],
                          'imagePath':
                              'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          'title': movie['title'],
                          'genre': genreNames,
                          'rating': movie['vote_average'].toStringAsFixed(1),
                        };
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    CustomMovieCard(
                      title: 'Suggestion From Scanning',
                      movies: movieListB,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16),
              child: CustomSearch(),
            ),
          ),
        ],
      ),
    );
  }
}
