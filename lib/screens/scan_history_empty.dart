import 'package:filmify/utils/image.dart';
import 'package:filmify/widgets/custom_empty_card.dart';
import 'package:filmify/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class ScanHistoryEmpty extends StatelessWidget {
  const ScanHistoryEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomHeader(
      title: "Scan History",
      hintText: "Cari Judul Film",
      content: [
        CustomEmptyCard(
          imagePath: scanHistoryEmpty,
          mainText: 'Oops! Your history is empty', // Teks utama
          descriptionText:
              'Scan your face to find the perfect movie recommendation for how you’re feeling right now.', // Deskripsi
        ),
      ],
    );
  }
}
