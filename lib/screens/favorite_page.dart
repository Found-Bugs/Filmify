import 'package:flutter/material.dart';

void main() {
  runApp(FavoriteApp());
}

class FavoriteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FavoritePage(),
    );
  }
}

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String _selectedFilter = "Recently";
  final List<String> _filters = ["Recently", "Highest Rated", "Most Popular"];

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
              // Favorite Title
              Center(
                child: Text(
                  "Favorite",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              // Search Bar with Bookmark
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
                      // Bookmark functionality here
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Filter Dropdown
              Align(
                alignment: Alignment.centerRight,
                child: DropdownButton<String>(
                  value: _selectedFilter,
                  icon: const Icon(Icons.arrow_left),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFilter = newValue!;
                    });
                  },
                  items: _filters.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              // Movie List
              buildMovieCard(
                imageUrl: "assets/img/Netflix.jpg",
                title: "The Wild Robot",
                genre: "Animation, Survival, Sci-Fi",
                rating: "7.4",
                description:
                    "After a shipwreck, an intelligent robot called Roz is stranded on an uninhabited island.",
              ),
              const SizedBox(height: 20),
              buildMovieCard(
                imageUrl: "assets/img/Heretic.jpg",
                title: "Inside Out 2",
                genre: "Animation, Adventure, Drama",
                rating: "7.6",
                description:
                    "A sequel that features Riley entering puberty and experiencing brand new, more complex emotions.",
              ),
              const SizedBox(height: 20),
              buildMovieCard(
                imageUrl: "assets/img/Netflix.jpg",
                title: "Transformer One",
                genre: "Action, Fantasy, Sci-Fi",
                rating: "7.7",
                description:
                    "The untold origin story of Optimus Prime and Megatron, better known as sworn enemies.",
              ),
              const SizedBox(height: 20),
              buildMovieCard(
                imageUrl: "assets/img/Heretic.jpg",
                title: "Venom: The Last Day",
                genre: "Superhero, Action, Sci-Fi",
                rating: "6.2",
                description:
                    "Eddie and Venom on the run, face pursuit from both worlds, as circumstances tighten.",
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
                        icon: const Icon(Icons.play_arrow, color: Colors.white),
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
                    Icons.bookmark,
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
