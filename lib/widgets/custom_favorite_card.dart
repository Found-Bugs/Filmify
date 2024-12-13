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
  bool isBookmarked = true;

  Future<void> toggleBookmark() async {
    if (isBookmarked) {
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(widget.movieId.toString())
          .delete();
    } else {
      final movie = {
        'id': widget.movieId,
        'title': widget.title,
        'genre': widget.genre,
        'rating': widget.rating,
        'description': widget.description,
        'imageUrl': widget.imageUrl,
      };
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(widget.movieId.toString())
          .set(movie);
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 0,
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Poster
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.imageUrl,
                    height: 170,
                    width: 100,
                    fit: BoxFit.cover,
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
                              ),
                            ),
                          ),
                          if (widget.showBookmark)
                            IconButton(
                              icon: Icon(
                                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
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
                          color: Colors.grey,
                          fontSize: 12,
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
                              fontSize: 16,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
