import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final String hintText;
  final List<Widget> content;

  const CustomHeader({
    super.key,
    required this.title,
    required this.hintText,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 45.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Center(
                  child: Text(
                    title, // Menggunakan parameter `title`
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...content, // Menampilkan konten dinamis
          ],
        ),
      ),
    );
  }
}
