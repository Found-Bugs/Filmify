import 'package:filmify/widgets/custom_favorite_card.dart';
import 'package:filmify/widgets/custom_header.dart';
import 'package:filmify/utils/image.dart';
import 'package:filmify/widgets/custom_empty_card.dart';
import 'package:flutter/material.dart';
import 'package:filmify/screens/favorite_model.dart';
import 'package:filmify/screens/favorite_storage.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final FavoriteStorage _storage = FavoriteStorage();
  List<FavoriteMovie> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await _storage.getFavorites();
    setState(() {
      _favorites = favorites;
    });
  }

  Future<void> _addFavorite(FavoriteMovie movie) async {
    await _storage.addFavorite(movie);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: _favorites.isEmpty
          ? const CustomHeader(
              title: "Favorite",
              hintText: "Cari Judul Film",
              content: [
                CustomEmptyCard(
                  imagePath: favoriteEmpty,
                  mainText: 'You haven’t added any favorites.',
                  descriptionText:
                      'Find movies you enjoy and save them here to easily access your top picks.',
                ),
              ],
            )
          : CustomHeader(
              title: "Favorite",
              hintText: "Cari Judul Film",
              content: _favorites
                  .map(
                    (movie) => Column(
                      children: [
                        CustomFavoriteCard(
                          imageUrl: movie.imageUrl,
                          title: movie.title,
                          genre: movie.genre,
                          rating: movie.rating,
                          description: movie.description,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
