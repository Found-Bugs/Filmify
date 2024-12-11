import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'favorite_model.dart';

class FavoriteStorage {
  static const String _key = 'favoriteMovies';

  Future<void> addFavorite(FavoriteMovie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteList = prefs.getStringList(_key) ?? [];
    favoriteList.add(jsonEncode(movie.toMap()));
    await prefs.setStringList(_key, favoriteList);
  }

  Future<List<FavoriteMovie>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteList = prefs.getStringList(_key) ?? [];
    return favoriteList
        .map((item) => FavoriteMovie.fromMap(jsonDecode(item)))
        .toList();
  }
}
