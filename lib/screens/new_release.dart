import 'package:flutter/material.dart';

void main() {
  runApp(NewReleaseApp());
}

class NewReleaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Release',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewReleasePage(),
    );
  }
}

class NewReleasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 16.0,
            left: 16.0,
            top: 50.0,
            bottom: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // New Release Title
              Center(
                child: Text(
                  "New Release",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              // Search Bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Judul Film',
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.bookmark, color: Colors.black),
                    iconSize: 30,
                    onPressed: () {
                      // Add filter functionality here
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Movie List
              buildMovieCard(
                imageUrl: "assets/img/Heretic.jpg",
                title: "Heretic",
                genre: "Horror, Thriller",
                rating: "7.2",
                description:
                    "Two young religious women are drawn into a game of cat-and-mouse in the house of a strange man.",
              ),
              const SizedBox(height: 20),
              buildMovieCard(
                imageUrl: "assets/img/stlt.jpg",
                title: "Small Things Like These",
                genre: "Drama, History",
                rating: "7.3",
                description:
                    "In 1985, a devoted father uncovers disturbing secrets kept by the local convent.",
              ),
              const SizedBox(height: 20),
              buildMovieCard(
                imageUrl: "assets/img/Bird.jpg",
                title: "Bird",
                genre: "Drama",
                rating: "7.2",
                description:
                    "Bailey lives with her brother Hunter and her father Bug in a small northern town.",
              ),
              const SizedBox(height: 20),
              buildMovieCard(
                imageUrl: "assets/img/wit.jpg",
                title: "Weekend in Taipei",
                genre: "Action, Thriller",
                rating: "5.8",
                description:
                    "A former DEA agent revisits their romance during a fateful weekend.",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Movie Card Widget
  Widget buildMovieCard({
    required String imageUrl,
    required String title,
    required String genre,
    required String rating,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Poster
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
                    height: 180,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),

                // Movie Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        genre,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.yellow, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            rating,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        label: const Text("Play Trailer"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    // Add bookmark functionality
                  },
                  icon: const Icon(
                    Icons.bookmark_border,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
