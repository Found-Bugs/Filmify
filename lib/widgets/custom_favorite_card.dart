import 'package:flutter/material.dart';
import 'package:filmify/screens/detail_movie.dart';

class CustomFavoriteCard extends StatelessWidget {
  final int movieId;
  final String imageUrl;
  final String title;
  final String genre;
  final String rating;
  final String description;
  final bool showBookmark;
  final VoidCallback? onBookmarkToggle;

  const CustomFavoriteCard({
    super.key,
    required this.movieId,
    required this.imageUrl,
    required this.title,
    required this.genre,
    required this.rating,
    required this.description,
    this.showBookmark = true,
    this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMovie(id: movieId),
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
                    imageUrl,
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
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white, // Warna teks putih
                            ),
                          ),
                        ),
                        if (showBookmark)
                          IconButton(
                            icon: Icon(
                              onBookmarkToggle != null
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: Colors.white,
                            ),
                            onPressed: onBookmarkToggle,
                          ),
                      ],
                    ),
                    Text(
                      genre,
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
                          rating,
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
                      description,
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
