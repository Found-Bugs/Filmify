import 'package:flutter/material.dart';

void main() {
  runApp(StreamPlatformApp());
}

class StreamPlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Platform',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamPlatformPage(),
    );
  }
}

class StreamPlatformPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 16.0,
            left: 16.0,
            top: 50.0,
            bottom: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tambahkan teks "Stream Platforms" di atas search bar
              Center(
                child: Text(
                  "Stream Platforms",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Platform',
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.bookmark, color: Colors.black),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Panggilan fungsi untuk menampilkan platform streaming
              buildPlatformCard(
                platformName: "Netflix",
                imageUrl: "assets/img/Netflix.jpg",
              ),
              const SizedBox(height: 20),
              buildPlatformCard(
                platformName: "Disney+ Hotstar",
                imageUrl: "assets/img/disney.jpg",
              ),
              const SizedBox(height: 20),
              buildPlatformCard(
                platformName: "Viu",
                imageUrl: "assets/img/Viu.jpg",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan nama platform dan gambar
  Widget buildPlatformCard(
      {required String platformName, required String imageUrl}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          platformName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
