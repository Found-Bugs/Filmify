import 'package:flutter/material.dart';

class CustomWatchOnItem extends StatelessWidget {
  final String imagePath;
  final String platformName;

  const CustomWatchOnItem({
    required this.imagePath,
    required this.platformName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 120, // Lebar setiap item
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Teks di kiri
        children: [
          // Gambar platform

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imagePath,
              height: 80,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          // Nama platform
          Text(
            platformName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left, // Pastikan teks di kiri
            maxLines: 2,
            overflow: TextOverflow.ellipsis, // Untuk teks panjang
          ),
        ],
      ),
    );
  }
}
