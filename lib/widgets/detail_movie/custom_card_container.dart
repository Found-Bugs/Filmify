import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:filmify/tmdb_api/api_service.dart';

class CustomCardContainer extends StatefulWidget {
  final Map<String, dynamic> movieDetails;
  final int movieId;

  const CustomCardContainer({
    super.key,
    required this.movieDetails,
    required this.movieId,
  });

  @override
  _CustomCardContainerState createState() => _CustomCardContainerState();
}

class _CustomCardContainerState extends State<CustomCardContainer> {
  bool isBookmarked = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checkIfBookmarked();
  }

  Future<void> checkIfBookmarked() async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    final userId = user.uid;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(widget.movieId.toString())
        .get();
    setState(() {
      isBookmarked = doc.exists;
    });
  }

  Future<void> toggleBookmark() async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    final userId = user.uid;
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(widget.movieId.toString());

    final movie = {
      'id': widget.movieId,
      'title': widget.movieDetails['title'],
      'genre': widget.movieDetails['genres']
          .map((genre) => genre['name'])
          .join(', '),
      'rating': widget.movieDetails['vote_average'].toString(),
      'description': widget.movieDetails['overview'],
      'imageUrl':
          'https://image.tmdb.org/t/p/w500${widget.movieDetails['poster_path']}',
    };

    if (isBookmarked) {
      await docRef.delete();
    } else {
      await docRef.set(movie);
    }

    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

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
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500${widget.movieDetails['poster_path']}'),
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
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? Colors.white : Colors.white,
            ),
            iconSize: 28,
            onPressed: toggleBookmark,
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
                widget.movieDetails['title'] ?? 'Unknown Title',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              // Description
              Text(
                widget.movieDetails['tagline'] ?? 'No description available.',
                style: const TextStyle(fontSize: 16, color: Colors.white70),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
