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
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: 40,
          width: 40,
        ),
        const SizedBox(height: 5),
        Text(
          platformName,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
