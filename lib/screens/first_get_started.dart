import 'package:filmify/screens/second_get_started.dart';
import 'package:filmify/utils/colors.dart';
import 'package:filmify/utils/image.dart';
import 'package:filmify/widgets/custom_button.dart';
import 'package:filmify/widgets/custom_card.dart';
import 'package:filmify/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

class FirstGetStarted extends StatelessWidget {
  const FirstGetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: backgroundGetStarted,
      spacing: 0.61,
      child: CustomCard(
        backgroundColor: customBackgroundColorDark,
        borderRadius: 0.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Selamat Datang di Filmify!',
              style: TextStyle(
                fontSize: 24,
                color: customTeksColorLight,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Temukan dunia film tanpa batas!',
              style: TextStyle(
                fontSize: 16,
                color: customTeksColorLight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              'Jelajahi koleksi film, review, dan rekomendasi yang akan memanjakan matamu. Satu tempat untuk segala hal tentang film yang kamu cintai.',
              style: TextStyle(
                fontSize: 14,
                color: customTeksColorLight.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Siap untuk memulai?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: customTeksColorLight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SecondGetStarted()),
                );
              },
              text: 'Next',
              backgroundColor: customButtonColorDark,
              textColor: customTeksColorLight,
            ),
          ],
        ),
      ),
    );
  }
}
