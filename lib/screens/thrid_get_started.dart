import 'package:filmify/screens/login.dart';
import 'package:filmify/screens/register.dart';
import 'package:filmify/utils/colors.dart';
import 'package:filmify/utils/image.dart';
import 'package:filmify/widgets/custom_button.dart';
import 'package:filmify/widgets/custom_card.dart';
import 'package:filmify/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ThridGetStarted extends StatelessWidget {
  const ThridGetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: backgroundWelcome,
      spacing: 0.24,
      centeredSection: Column(
        children: [
          const Center(
            child: Text(
              'Welcome To Filmify',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: customTeksColorLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Discover movies that match your mood, an unique app that '
            'recognizes your facial expressions to offer personalized and enjoyable recommendations.',
            style: TextStyle(
              fontSize: 16,
              color: customTeksColorLight.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      child: CustomCard(
        backgroundColor: customBackgroundColorDark,
        borderRadius: 20.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: customTeksColorLight,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Get Started with your account',
              style: TextStyle(
                fontSize: 16,
                color: customTeksColorLight.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Login()),
                );
              },
              text: 'Login',
              backgroundColor: customButtonColorDark,
              textColor: customTeksColorLight,
            ),
            const SizedBox(height: 10),
            Text(
              'or',
              style: TextStyle(
                fontSize: 16,
                color: customTeksColorLight.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 10),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Register()),
                );
              },
              text: 'Create Account',
              backgroundColor: customButtonColorLight,
              textColor: customTeksColorDark,
            ),
          ],
        ),
      ),
    );
  }
}
