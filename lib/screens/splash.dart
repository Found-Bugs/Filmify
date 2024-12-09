import 'package:filmify/screens/first_get_started.dart';
import 'package:filmify/utils/image.dart';
import 'package:filmify/utils/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const FirstGetStarted()));
    });
    return Scaffold(
      backgroundColor: customBackgroundColorLight,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double imageSize = constraints.maxWidth * 1;
            return Image.asset(
              logo,
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
