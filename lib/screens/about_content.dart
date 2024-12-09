import 'package:filmify/widgets/detail_movie/custom_watch_on_item.dart';
import 'package:flutter/material.dart';

class AboutContent extends StatelessWidget {
  final Map<String, dynamic> movie; // Perbarui tipe data

  const AboutContent({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Synopsis',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          movie['synopsis'] ?? 'No synopsis available.',
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 20),
        const Text(
          'Genre',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(movie['genre'] ?? 'Unknown'),
        const SizedBox(height: 20),
        const Text(
          'Director',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(movie['director'] ?? 'Unknown'),
        const SizedBox(height: 20),
        const Text(
          'Writers',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(movie['writers'] ?? 'Unknown'),
        const SizedBox(height: 20),
        const Text(
          'Watch On',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 80, // Tinggi widget untuk scroll horizontal
          child: ListView(
            scrollDirection: Axis.horizontal, // Scrollable ke kanan/kiri
            children: const [
              CustomWatchOnItem(
                imagePath: 'assets/images/netflix.png',
                platformName: 'Netflix',
              ),
              SizedBox(width: 10),
              CustomWatchOnItem(
                imagePath: 'assets/images/disney.png',
                platformName: 'Disney+ Hotstar',
              ),
              SizedBox(width: 10),
              CustomWatchOnItem(
                imagePath: 'assets/images/viu.png',
                platformName: 'Viu',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
