import 'package:filmify/screens/splash2_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Splash2Screen()));
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double imageSize = constraints.maxWidth * 1;
            return Image.asset(
              'assets/Splash.png', // Adjust path as per your assets
              width: imageSize,
              height: imageSize,
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}
