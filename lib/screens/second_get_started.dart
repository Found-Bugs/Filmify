import 'package:filmify/screens/thrid_get_started.dart';
import 'package:filmify/utils/colors.dart';
import 'package:filmify/utils/image.dart';
import 'package:filmify/widgets/custom_button.dart';
import 'package:filmify/widgets/custom_card.dart';
import 'package:filmify/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

class SecondGetStarted extends StatelessWidget {
  const SecondGetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: backgroundGetStarted,
      spacing: 0.62,
      child: CustomCard(
        backgroundColor: customBackgroundColorDark,
        borderRadius: 0.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Gabung dan Mulai Perjalanan Sinematikmu!',
              style: TextStyle(
                fontSize: 24,
                color: customTeksColorLight,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Ayo, buat akun untuk mendapatkan rekomendasi film personal dan berbagai fitur menarik. Satu klik, ribuan film menantimu!',
              style: TextStyle(
                fontSize: 14,
                color: customTeksColorLight.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Masuk atau Daftar sekarang.',
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
                      builder: (context) => const ThridGetStarted()),
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
