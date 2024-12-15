import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:filmify/widgets/custom_favorite_card.dart';
import 'package:filmify/widgets/custom_header.dart';
import 'package:filmify/utils/image.dart';
import 'package:filmify/widgets/custom_empty_card.dart';

class Favorite extends StatelessWidget {
  Favorite({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    if (user == null) {
      return const Center(child: Text('Please log in to see your favorites.'));
    }

    final userId = user.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: _db
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const CustomHeader(
            title: "Favorite",
            hintText: "Cari Judul Film",
            content: [
              CustomEmptyCard(
                imagePath: favoriteEmpty,
                mainText: 'You haven’t added any favorites.', // Teks utama
                descriptionText:
                    'Find movies you enjoy and save them here to easily access your top picks.', // Deskripsi
              ),
            ],
          );
        }
        final favorites = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            'movieId': int.parse(doc.id),
            'imageUrl': data['imageUrl'],
            'title': data['title'],
            'genre': data['genre'],
            'rating':
                double.parse(data['rating'].toString()).toStringAsFixed(1),
            'description': data['description'],
          };
        }).toList();

        return CustomHeader(
          title: "Favorite",
          hintText: "Search Movie Title",
          content: favorites
              .map(
                (movie) => Column(
                  children: [
                    CustomFavoriteCard(
                      movieId: movie["movieId"]!,
                      imageUrl: movie["imageUrl"]!,
                      title: movie["title"]!,
                      genre: movie["genre"]!,
                      rating: movie["rating"]!,
                      description: movie["description"]!,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
              .toList(),
        );
      },
    );
  }
}
