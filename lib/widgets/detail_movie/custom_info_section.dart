import 'package:flutter/material.dart';

class CustomInfoSection extends StatelessWidget {
  final Map<String, dynamic> movie; // Perbarui tipe data

  const CustomInfoSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Release Date
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 24, color: Colors.black),
              const SizedBox(width: 8),
              Text(
                movie['releaseDate'] ?? 'Unknown',
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),

          // Duration
          Row(
            children: [
              const Icon(Icons.access_time, size: 24, color: Colors.black),
              const SizedBox(width: 8),
              Text(
                movie['duration'] ?? 'Unknown',
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),

          // Rating
          Row(
            children: [
              const Icon(Icons.movie_filter, size: 24, color: Colors.black),
              const SizedBox(width: 8),
              Text(
                movie['rating'] ?? 'NR',
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
