import 'package:filmify/screens/bottom_nav_bar.dart';
import 'package:filmify/screens/register.dart';
import 'package:filmify/utils/colors.dart';
import 'package:filmify/utils/image.dart';
import 'package:filmify/widgets/custom_button.dart';
import 'package:filmify/widgets/custom_card.dart';
import 'package:filmify/widgets/custom_scaffold.dart';
import 'package:filmify/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: backgroundWelcome,
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
              'Login to Filmify',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              fieldName: 'Email or Username',
              fieldNameColor: customTeksColorLight.withOpacity(0.7),
              hintText: 'Username or Email',
            ),
            const SizedBox(height: 10),
            CustomTextField(
              fieldName: 'Password',
              fieldNameColor: customTeksColorLight.withOpacity(0.7),
              hintText: 'Password',
              isPassword: true,
              suffixIcon: Icons.visibility_off,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Handle forgot password action
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavBar()),
                );
              },
              text: 'Login',
              backgroundColor: customButtonColorDark,
              textColor: customTeksColorLight,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.white70),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Register()),
                    );
                  },
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                        color: Color(0xFF5751F7), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
