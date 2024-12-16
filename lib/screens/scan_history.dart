import 'dart:math';
import 'package:filmify/screens/detail_movie.dart';
import 'package:filmify/tmdb_api/api_service.dart';
import 'package:filmify/utils/image.dart';
import 'package:filmify/widgets/custom_empty_card.dart';
import 'package:filmify/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:filmify/services/auth_service.dart';

class ScanHistory extends StatefulWidget {
  const ScanHistory({super.key});

  @override
  _ScanHistoryState createState() => _ScanHistoryState();
}

class _ScanHistoryState extends State<ScanHistory> {
  List<Map<String, dynamic>> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final authService = AuthService();
      final history = await authService.fetchPredictionHistory(user.uid);
      for (var item in history) {
        final emotion = item['prediction']['predicted_class'];
        item['recommendations'] = await _fetchRecommendedMovies(emotion);
      }
      setState(() {
        _history = history;
        _isLoading = false;
      });
    }
  }

  Future<List<Map<String, dynamic>>> _fetchRecommendedMovies(
      String emotion) async {
    final apiService = TMDBApiService();
    List<int> genreIds;

    switch (emotion) {
      case 'sad':
        genreIds = [18, 10749]; // Drama, Romance
        break;
      case 'neutral':
        genreIds = [99, 10751]; // Documentary, Slice of Life
        break;
      case 'happy':
        genreIds = [35, 10402, 12, 14]; // Comedy, Musical, Adventure, Fantasy
        break;
      case 'angry':
        genreIds = [28, 53, 27]; // Action, Thriller, Horror
        break;
      default:
        genreIds = [];
    }

    List<Map<String, dynamic>> recommendedMovies = [];
    for (int genreId in genreIds) {
      final movies = await apiService.getMoviesByGenre(genreId);
      recommendedMovies.addAll(movies);
    }

    // Shuffle the list to make the recommendations random
    recommendedMovies.shuffle(Random());

    return recommendedMovies;
  }

  Future<void> _removeHistoryItem(int index) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final authService = AuthService();
      await authService.removePredictionFromHistory(user.uid, _history[index]['id']);
      setState(() {
        _history.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      title: "Scan History",
      hintText: "Cari Judul Film",
      content: [
        const SizedBox(height: 20),
        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else if (_history.isEmpty)
          const CustomEmptyCard(
            imagePath: scanHistoryEmpty,
            mainText: 'Oops! Your history is empty',
            descriptionText:
                'Scan your face to find the perfect movie recommendation for how you’re feeling right now.',
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              _history.length,
              (index) {
                final item = _history[index];

                return Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Center(
                            child: Text(
                              "Scan Result",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeHistoryItem(index),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item['image_url'],
                              fit: BoxFit.cover,
                              width: 140,
                              height: 210,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expression: ${item['prediction']['predicted_class'][0].toUpperCase() + item['prediction']['predicted_class'].substring(1)}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Angry: ${(item['prediction']['confidence_scores']['angry'] * 100).toStringAsFixed(2)}%',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                Text(
                                  'Happy: ${(item['prediction']['confidence_scores']['happy'] * 100).toStringAsFixed(2)}%',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                Text(
                                  'Neutral: ${(item['prediction']['confidence_scores']['neutral'] * 100).toStringAsFixed(2)}%',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                Text(
                                  'Sad: ${(item['prediction']['confidence_scores']['sad'] * 100).toStringAsFixed(2)}%',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Recommended Movies",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (item['recommendations'].isEmpty)
                        const Center(child: Text('No recommendations available.'))
                      else
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: item['recommendations'].length,
                            itemBuilder: (context, index) {
                              final movie = item['recommendations'][index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailMovie(id: movie['id']),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 110,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                          fit: BoxFit.cover,
                                          width: 110,
                                          height: 160,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        movie['title'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
