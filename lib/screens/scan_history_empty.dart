// import 'package:filmify/utils/image.dart';
// import 'package:filmify/widgets/custom_empty_card.dart';
// import 'package:filmify/widgets/custom_header.dart';
// import 'package:flutter/material.dart';

// class ScanHistoryEmpty extends StatelessWidget {
//   const ScanHistoryEmpty({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const CustomHeader(
//       title: "Scan History",
//       hintText: "Cari Judul Film",
//       content: [
//         CustomEmptyCard(
//           imagePath: scanHistoryEmpty,
//           mainText: 'Oops! Your history is empty', // Teks utama
//           descriptionText:
//               'Scan your face to find the perfect movie recommendation for how you’re feeling right now.', // Deskripsi
//         ),
//       ],
//     );
//   }
// }

import 'package:filmify/data/data_movie_A.dart';
import 'package:filmify/screens/detail_movie.dart';
import 'package:filmify/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class ScanHistory extends StatelessWidget {
  const ScanHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      title: "Scan History",
      hintText: "Cari Judul Film",
      content: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16), // Padding dalam container
          decoration: BoxDecoration(
            color: Colors.white, // Latar belakang putih
            borderRadius: BorderRadius.circular(12), // Sudut melengkung
            border: Border.all(
              color: Colors.grey.withOpacity(0.5), // Warna border abu-abu
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Bayangan halus
                blurRadius: 4,
                offset: const Offset(0, 2), // Posisi bayangan
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul Scan Result
              const Center(
                child: Text(
                  "Scan Result",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Teks Expression
              const Text(
                "Expression : Sad",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Teks Recommendation Genres
              const Text(
                "Recommendation Genres : Comedy",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Daftar Film
              CustomHistoryCard(
                movies: movieListA,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// import 'package:filmify/screens/detail_movie.dart';
// import 'package:flutter/material.dart';

class CustomHistoryCard extends StatelessWidget {
  final List<Map<String, dynamic>> movies; // Ubah tipe data

  const CustomHistoryCard({
    super.key,
    required this.movies, // Data film diterima melalui parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                  // Navigasi ke halaman detail
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DetailMovie(movie: movie),
                  //   ),
                  // );
                },
                child: Container(
                  width: 110,
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          movie['imagePath']!,
                          fit: BoxFit.cover,
                          width: 110,
                          height: 160,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie['title']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
