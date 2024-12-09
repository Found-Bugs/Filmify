import 'package:flutter/material.dart';

class CustomCardContainer extends StatelessWidget {
  final Map<String, dynamic> movie; // Perbarui tipe data

  const CustomCardContainer({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Background Image
        Container(
          width: screenWidth, // Full width
          height: 400, // Set height for the card
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage(movie['imagePath'] ?? 'assets/images/default.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Dark overlay for text
        Container(
          width: screenWidth,
          height: 400,
          color: Colors.black.withOpacity(0.6),
        ),

        // Back and Bookmark Buttons
        Positioned(
          top: 30, // Adjust to place the buttons properly
          left: 15,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            iconSize: 28,
            onPressed: () {
              Navigator.pop(context); // Navigate back
            },
          ),
        ),
        Positioned(
          top: 30,
          right: 15,
          child: IconButton(
            icon: const Icon(Icons.bookmark_border),
            color: Colors.white,
            iconSize: 28,
            onPressed: () {
              // Handle bookmark action
            },
          ),
        ),

        // Content inside the card
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Play Trailer Button
              ElevatedButton.icon(
                onPressed: () {
                  // Handle play trailer action
                },
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                label: const Text(
                  'Play Trailer',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Title
              Text(
                movie['title'] ?? 'Unknown Title',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              // Description
              Text(
                movie['description'] ?? 'No description available.',
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
