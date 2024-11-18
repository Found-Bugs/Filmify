import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
            right: 16.0, left: 16.0, top: 50.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari Judul Film',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: PageView(
                controller: _pageController,
                children: [
                  buildBannerImage('assets/hero.png'),
                  buildBannerImage('assets/hero.png'),
                  buildBannerImage('assets/hero.png'),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: Colors.indigo,
                    dotColor: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildCategoryIcon(Icons.movie, 'Genres'),
                buildCategoryIcon(Icons.tv, 'Platforms'),
                buildCategoryIcon(Icons.theaters, 'Cinemas'),
                buildCategoryIcon(Icons.new_releases, 'New Release'),
              ],
            ),
            const SizedBox(height: 20),
            buildSectionHeader('Recommended Movies', () {}),
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildMovieCard('assets/cover1.png', 'Deadpool & Wolverine',
                      'Action, Comedy, Superhero', '7.8'),
                  buildMovieCard('assets/cover2.png', '3 Idiots',
                      'Comedy, Drama', '8.4'),
                  buildMovieCard('assets/cover3.png', 'Nobody',
                      'Action, Crime, Drama', '7.4'),
                  buildMovieCard('assets/cover1.png', 'The Witcher',
                      'Animation, Fantasy, Action', '8.3'),
                ],
              ),
            ),
            buildSectionHeader('Suggestion From Scanning', () {}),
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildMovieCard('assets/cover1.png', 'Deadpool & Wolverine',
                      'Action, Comedy, Superhero', '7.8'),
                  buildMovieCard('assets/cover2.png', '3 Idiots',
                      'Comedy, Drama', '8.4'),
                  buildMovieCard('assets/cover3.png', 'Nobody',
                      'Action, Crime, Drama', '7.4'),
                  buildMovieCard('assets/cover1.png', 'The Witcher',
                      'Animation, Fantasy, Action', '8.3'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBannerImage(String imagePath) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, right: 5, left: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget buildCategoryIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget buildSectionHeader(String title, VoidCallback onSeeMore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onSeeMore,
          child: const Text('See More'),
        ),
      ],
    );
  }

  Widget buildMovieCard(
      String imagePath, String title, String genre, String rating) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 110,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(
            genre,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(rating, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}