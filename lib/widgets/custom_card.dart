import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget? child; // Isi dari kolom
  final Color backgroundColor; // Warna latar belakang
  final double borderRadius; // Radius border

  const CustomCard({
    super.key,
    required this.child,
    required this.backgroundColor,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
      ),
      child: child,
    );
  }
}
