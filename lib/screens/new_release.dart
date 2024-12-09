import 'package:filmify/widgets/custom_favorite_card.dart';
import 'package:filmify/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class NewRelease extends StatelessWidget {
  const NewRelease({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomHeader(
      title: "New Release",
      hintText: "Cari Judul Film",
      content: [
        CustomFavoriteCard(
          imageUrl: "lib/assets/images/cover1.png",
          title: "Heretic",
          genre: "Horror, Thriller",
          rating: "7.2",
          description:
              "Two young religious women are drawn into a game of cat-and-mouse in the house of a strange man.",
        ),
        SizedBox(height: 20),
        CustomFavoriteCard(
          imageUrl: "lib/assets/images/cover1.png",
          title: "Small Things Like These",
          genre: "Drama, History",
          rating: "7.3",
          description:
              "In 1985, a devoted father uncovers disturbing secrets kept by the local convent.",
        ),
        SizedBox(height: 20),
        CustomFavoriteCard(
          imageUrl: "lib/assets/images/cover1.png",
          title: "Bird",
          genre: "Drama",
          rating: "7.2",
          description:
              "Bailey lives with her brother Hunter and her father Bug in a small northern town.",
        ),
        SizedBox(height: 20),
        CustomFavoriteCard(
          imageUrl: "lib/assets/images/cover1.png",
          title: "Weekend in Taipei",
          genre: "Action, Thriller",
          rating: "5.8",
          description:
              "A former DEA agent revisits their romance during a fateful weekend.",
        ),
      ],
    );
  }
}
