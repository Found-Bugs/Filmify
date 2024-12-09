import 'package:filmify/widgets/custom_favorite_card.dart';
import 'package:filmify/widgets/custom_header.dart';
import 'package:filmify/utils/image.dart';
import 'package:filmify/widgets/custom_empty_card.dart';
import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  Favorite({super.key});
  // Dummy data: Replace this with your actual data source.
  final List<Map<String, String>> favorites = [
    // Uncomment this list to test empty state:
    // If you want to simulate empty, leave this as an empty list: []
    {
      "imageUrl": "lib/assets/images/cover1.png",
      "title": "Heretic",
      "genre": "Horror, Thriller",
      "rating": "7.2",
      "description":
          "Two young religious women are drawn into a game of cat-and-mouse in the house of a strange man.",
    },
    {
      "imageUrl": "lib/assets/images/cover1.png",
      "title": "Small Things Like These",
      "genre": "Drama, History",
      "rating": "7.3",
      "description":
          "In 1985, a devoted father uncovers disturbing secrets kept by the local convent.",
    },
    {
      "imageUrl": "lib/assets/images/cover1.png",
      "title": "Bird",
      "genre": "Drama",
      "rating": "7.2",
      "description":
          "Bailey lives with her brother Hunter and her father Bug in a small northern town.",
    },
    {
      "imageUrl": "lib/assets/images/cover1.png",
      "title": "Weekend in Taipei",
      "genre": "Action, Thriller",
      "rating": "5.8",
      "description":
          "A former DEA agent revisits their romance during a fateful weekend.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return favorites.isEmpty
        ? const CustomHeader(
            title: "Favorite",
            hintText: "Cari Judul Film",
            content: [
              CustomEmptyCard(
                imagePath: favoriteEmpty,
                mainText: 'You haven’t added any favorites.', // Teks utama
                descriptionText:
                    'Find movies you enjoy and save them here to easily access your top picks.', // Deskripsi
              ),
            ],
          )
        : CustomHeader(
            title: "Favorite",
            hintText: "Cari Judul Film",
            content: favorites
                .map(
                  (movie) => Column(
                    children: [
                      CustomFavoriteCard(
                        imageUrl: movie["imageUrl"]!,
                        title: movie["title"]!,
                        genre: movie["genre"]!,
                        rating: movie["rating"]!,
                        description: movie["description"]!,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
                .toList(),
          );
  }
}
