import 'package:flutter/material.dart';
import 'package:filmify/utils/colors.dart';

class CustomScaffold extends StatelessWidget {
  final String backgroundImage; // Path untuk gambar background
  final Widget child; // Isi dari Container di Stack
  final Widget? centeredSection; // Parameter opsional untuk bagian tengah
  final double? spacing;

  const CustomScaffold({
    super.key,
    required this.backgroundImage,
    required this.child,
    this.centeredSection,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
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
              color: customBackgroundColorDark.withOpacity(0.8),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (centeredSection != null) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 75.0),
                        child: centeredSection!,
                      ),
                    ],
                    if (spacing != null)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * spacing!,
                      ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: child,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
