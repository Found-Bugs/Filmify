import 'dart:convert';
import 'package:http/http.dart' as http;
import '../TMDB_api/dependencies.dart';

class DataBanner {
  static const List<String> subtitles = [
    'Tonton film-film terbaik pilihan di FilmiFace dan temukan petualangan baru di setiap genre favoritmu!',
    'Temukan genre yang sesuai dengan suasana hatimu dan nikmati rekomendasi film terbaik!',
    'Jangan lewatkan rilis terbaru dari berbagai film favoritmu di FilmiFace!',
  ];

  static const List<String> title = [
    'Watch Popular Movies',
    'Explore Genres',
    'New Releases',
  ];
  static Future<List<Map<String, String>>> fetchBanners() async {
    final url = Uri.parse('$baseUrl/movie/popular?api_key=$apiKey');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List movies = data['results'];

        // Batasi hanya 3 banner yang diambil
        return List<Map<String, String>>.generate(
          3,
          (index) {
            final movie = movies[index % movies.length];
            return {
              'imagePath':
                  'https://image.tmdb.org/t/p/w500${movie['backdrop_path'] ?? ''}',
              'title': title[index],
              'subtitle': subtitles[index],
            };
          },
        );
      } else {
        throw Exception(
            'Failed to fetch banners. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching banners: $e');
    }
  }
}
