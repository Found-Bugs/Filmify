import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dependencies.dart';

class TMDBApiService {
  static const String _cacheKey = 'searchMoviesCache';
  static const String _genresCacheKey = 'genresCache';

  Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = prefs.getString('$_cacheKey-$query');

    if (cacheData != null) {
      final data = jsonDecode(cacheData);
      return List<Map<String, dynamic>>.from(data['results'].map((movie) => {
            'id': movie['id'],
            'title': movie['title'],
            'poster_path': movie['poster_path'],
          }));
    }

    final response = await http
        .get(Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await prefs.setString('$_cacheKey-$query', response.body);
      return List<Map<String, dynamic>>.from(data['results'].map((movie) => {
            'id': movie['id'],
            'title': movie['title'],
            'poster_path': movie['poster_path'],
          }));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Map<String, dynamic>>> getGenres() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = prefs.getString(_genresCacheKey);

    if (cacheData != null) {
      final data = jsonDecode(cacheData);
      return List<Map<String, dynamic>>.from(data['genres'].map((genre) => {
            'id': genre['id'],
            'name': genre['name'],
          }));
    }

    final response =
        await http.get(Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await prefs.setString(_genresCacheKey, response.body);
      return List<Map<String, dynamic>>.from(data['genres'].map((genre) => {
            'id': genre['id'],
            'name': genre['name'],
          }));
    } else {
      throw Exception('Failed to load genres');
    }
  }
}
