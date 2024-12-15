import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmify/screens/detail_movie.dart';

class CustomFavoriteCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String genre;
  final String rating;
  final String description;
  final int movieId;
  final bool showBookmark;

  const CustomFavoriteCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.genre,
    required this.rating,
    required this.description,
    required this.movieId,
    this.showBookmark = true, // Default value is true
  });

  @override
  _CustomFavoriteCardState createState() => _CustomFavoriteCardState();
}

class _CustomFavoriteCardState extends State<CustomFavoriteCard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isBookmarked = true;

  Future<void> toggleBookmark() async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    final userId = user.uid;
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(widget.movieId.toString());

    if (isBookmarked) {
      await docRef.delete();
    } else {
      final movie = {
        'id': widget.movieId,
        'title': widget.title,
        'genre': widget.genre,
        'rating': widget.rating,
        'description': widget.description,
        'imageUrl': widget.imageUrl,
      };
      await docRef.set(movie);
    }

    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMovie(id: widget.movieId),
          ),
        );
      },
      child: Card(
        elevation: 3, // Tambahkan elevation untuk memberi efek bayangan
        color: Colors.blue.shade900, // Gunakan warna abu-abu
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Tambahkan border radius
        ),
        child: Padding(
          // Gunakan padding untuk ruang internal
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie Poster
              Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.white, width: 3), // Border putih
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.network(
                    widget.imageUrl,
                    height: 170,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),

              // Movie Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white, // Warna teks putih
                            ),
                          ),
                        ),
                        if (widget.showBookmark)
                          IconButton(
                            icon: Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: isBookmarked ? Colors.white : Colors.white,
                            ),
                            onPressed: toggleBookmark,
                          ),
                      ],
                    ),
                    Text(
                      widget.genre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70, // Warna teks abu-abu muda
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          widget.rating,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white, // Warna teks putih
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Warna teks putih
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
