import 'dart:convert';

import 'package:filmify/widgets/detail_movie/custom_watch_on_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:filmify/tmdb_api/dependencies.dart';

class AboutContent extends StatefulWidget {
  final Map<String, dynamic> movie;

  const AboutContent({super.key, required this.movie});

  @override
  _AboutContentState createState() => _AboutContentState();
}

class _AboutContentState extends State<AboutContent> {
  List<Map<String, dynamic>> watchProviders = [];

  @override
  void initState() {
    super.initState();
    fetchWatchProviders();
  }

  // Fetch watch providers from the API
  Future<void> fetchWatchProviders() async {
    final movieId = widget.movie['id'];
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/watch/providers?api_key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as Map<String, dynamic>;

        // Extract the providers for each region (e.g., US, IN, etc.)
        final providers = results['ID']?['flatrate'] as List<dynamic> ?? [];
        setState(() {
          watchProviders = providers.map((provider) {
            return {
              'name': provider['provider_name'] ?? 'Unknown',
              'image':
                  'https://image.tmdb.org/t/p/w500${provider['logo_path']}', // Assuming you have images for each provider
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load watch providers');
      }
    } catch (e) {
      print('Error fetching watch providers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Synopsis',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          widget.movie['overview'] ?? 'No overview available.',
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 20),
        const Text(
          'Genres',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          widget.movie['genres'] != null && widget.movie['genres'] is List
              ? (widget.movie['genres'] as List)
                  .map((genre) => genre['name'])
                  .join(', ') // Menggabungkan nama genre dengan koma
              : 'Unknown',
        ),
        const SizedBox(height: 20),
        const Text(
          'Production Companies',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          widget.movie['production_companies'] != null &&
                  widget.movie['production_companies'] is List
              ? (widget.movie['production_companies'] as List)
                  .map((genre) => genre['name'])
                  .join(', ') // Menggabungkan nama genre dengan koma
              : 'Unknown',
        ),
        const SizedBox(height: 20),
        // const Text(
        //   'Release Status',
        //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        // ),
        // const SizedBox(height: 10),
        // Text(movie['status'] ?? 'Unknown'),
        // const SizedBox(height: 20),
        const Text(
          'Watch On',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150, // Tinggi widget untuk scroll horizontal
          child: watchProviders.isEmpty
              ? Center(
                  child: Text(
                    'No Stream Platform',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                )
              : ListView(
                  scrollDirection: Axis.horizontal, // Scrollable ke kanan/kiri
                  children: watchProviders.map((provider) {
                    return CustomWatchOnItem(
                      imagePath:
                          provider['image'] ?? 'assets/images/unknown.png',
                      platformName: provider['name'] ?? 'Unknown',
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }
}
