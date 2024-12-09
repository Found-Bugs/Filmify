import 'package:filmify/widgets/custom_header.dart';
import 'package:filmify/widgets/custom_movie_card.dart';
import 'package:flutter/material.dart';
import 'package:filmify/data/data_movie_A.dart';
import 'package:filmify/data/data_movie_B.dart';

class Genres extends StatelessWidget {
  const Genres({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      title: "Genres",
      hintText: "Cari Judul Film",
      content: [
        CustomMovieCard(
          title: 'Action',
          movies: movieListA,
        ),
        const SizedBox(height: 20),
        CustomMovieCard(
          title: 'Adventure',
          movies: movieListB,
        ),
        const SizedBox(height: 20),
        CustomMovieCard(
          title: 'Animatnion',
          movies: movieListA,
        ),
      ],
    );
  }
}
