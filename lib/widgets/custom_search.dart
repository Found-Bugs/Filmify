import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari Judul Film',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.bookmark, color: Colors.black),
          onPressed: () {
            // Aksi tombol bookmark
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bookmark ditekan!')),
            );
          },
        ),
      ],
    );
  }
}
