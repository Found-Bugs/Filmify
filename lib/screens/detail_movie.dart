import 'package:filmify/widgets/detail_movie/custom_card_container.dart';
import 'package:filmify/widgets/detail_movie/custom_details_container.dart';
import 'package:filmify/widgets/detail_movie/custom_info_section.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailMovie extends StatefulWidget {
  final int id;

  const DetailMovie({super.key, required this.id});

  @override
  _DetailMovieState createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  int _selectedTabIndex = 0;

  Map<String, dynamic>? movieDetails;
  List<Map<String, dynamic>> reviews = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {
    final apiKey =
        'addb1cf6faf851a8b493e32da583c10f'; // Ganti dengan API Key TMDB Anda
    final movieUrl =
        'https://api.themoviedb.org/3/movie/${widget.id}?api_key=$apiKey';
    final reviewsUrl =
        'https://api.themoviedb.org/3/movie/${widget.id}/reviews?api_key=$apiKey';

    try {
      // Fetch movie details
      final movieResponse = await http.get(Uri.parse(movieUrl));
      if (movieResponse.statusCode == 200) {
        setState(() {
          movieDetails = json.decode(movieResponse.body);
        });
      } else {
        throw Exception('Failed to load movie details');
      }

      // Fetch movie reviews
      final reviewsResponse = await http.get(Uri.parse(reviewsUrl));
      if (reviewsResponse.statusCode == 200) {
        final reviewData = json.decode(reviewsResponse.body);
        setState(() {
          reviews = (reviewData['results'] as List)
              .map((review) => {
                    'author': review['author'] ?? 'Unknown',
                    'content': review['content'] ?? 'No content',
                    'rating': review['author_details']['rating'],
                    'avatar': review['author_details']['avatar_path'],
                  })
              .take(5)
              .toList();
        });
      } else {
        throw Exception('Failed to load reviews');
      }

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching movie details or reviews: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (movieDetails == null) {
      return Scaffold(
        body: Center(
          child: Text('Failed to load movie details.'),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCardContainer(movie: movieDetails!),
            CustomInfoSection(movie: movieDetails!),
            CustomDetailsContainer(
              selectedTabIndex: _selectedTabIndex,
              onTabSelected: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              movie: movieDetails!,
              reviews: reviews,
            ),
          ],
        ),
      ),
    );
  }
}
