import 'package:filmify/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String backgroundImage; // Path untuk gambar background
  final Widget child; // Isi dari Container di Stack
  final Widget? centeredSection; // Parameter opsional untuk bagian tengah

  const CustomScaffold({
    super.key,
    required this.backgroundImage,
    required this.child,
    this.centeredSection,
  });

  @override
  Widget build(BuildContext context) {
    // Checking if the keyboard is visible
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              color: customOpacityColor.withOpacity(0.7),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (centeredSection != null && !keyboardVisible) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 75.0,
                      ),
                      child: centeredSection!,
                    ),
                  ],
                  Expanded(
                    child: Align(
                      alignment: Alignment
                          .bottomCenter, // Content will align to the bottom
                      child: child, // Main content (like form, buttons)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
