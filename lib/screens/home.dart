import 'package:filmify/screens/genres.dart';
import 'package:filmify/screens/cinemas.dart';
import 'package:filmify/screens/new_release.dart';
import 'package:filmify/screens/platforms.dart';
import 'package:filmify/widgets/custom_carousel.dart';
import 'package:filmify/widgets/custom_menu.dart';
import 'package:filmify/widgets/custom_movie_card.dart';
import 'package:filmify/widgets/custom_search.dart';
import 'package:flutter/material.dart';
import 'package:filmify/data/data_movie_A.dart';
import 'package:filmify/data/data_movie_B.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 45.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSearch(),
              const SizedBox(height: 10),
              const CustomCarousel(),
              const SizedBox(height: 20),
              CustomMenu(
                categories: [
                  {
                    'icon': Icons.movie,
                    'label': 'Genres',
                    'onTap': () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Genres()),
                      );
                    },
                  },
                  {
                    'icon': Icons.tv,
                    'label': 'Platforms',
                    'onTap': () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Platforms()),
                      );
                    },
                  },
                  {
                    'icon': Icons.theaters,
                    'label': 'Cinemas',
                    'onTap': () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Cinemas()),
                      );
                    },
                  },
                  {
                    'icon': Icons.new_releases,
                    'label': 'New Release',
                    'onTap': () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewRelease()),
                      );
                    },
                  },
                ],
              ),
              const SizedBox(height: 20),
              CustomMovieCard(
                title: 'Recommended Movies',
                movies: movieListA,
              ),
              const SizedBox(height: 20),
              CustomMovieCard(
                title: 'Suggestion From Scanning',
                movies: movieListB,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
