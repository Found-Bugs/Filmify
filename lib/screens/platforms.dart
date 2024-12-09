import 'package:filmify/widgets/custom_header.dart';
import 'package:filmify/widgets/custom_platform_card.dart';
import 'package:flutter/material.dart';

class Platforms extends StatelessWidget {
  const Platforms({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomHeader(
      title: "Stream Platform",
      hintText: "Cari Nama Platform",
      content: [
        CustomPlatformCard(
          platformName: "Netflix",
          imageUrl: "lib/assets/images/hero.png",
        ),
        SizedBox(height: 20),
        CustomPlatformCard(
          platformName: "Disney+ Hotstar",
          imageUrl: "lib/assets/images/hero.png",
        ),
        SizedBox(height: 20),
        CustomPlatformCard(
          platformName: "Viu",
          imageUrl: "lib/assets/images/hero.png",
        ),
      ],
    );
  }
}
