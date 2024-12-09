import 'package:filmify/screens/login.dart';
import 'package:filmify/utils/colors.dart';
import 'package:filmify/widgets/custom_button.dart';
import 'package:filmify/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Your Account!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              const CustomTextField(
                fieldName: 'Full Name',
                fieldNameColor: customTeksColorDark,
                hintText: 'example. Septa Puma',
                borderSide: BorderSide(),
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                fieldName: 'Email',
                fieldNameColor: customTeksColorDark,
                hintText: 'example@example.com',
                borderSide: BorderSide(),
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                fieldName: 'Date of Birth',
                fieldNameColor: customTeksColorDark,
                hintText: 'DD / MM / YYYY',
                isPassword: true,
                suffixIcon: Icons.calendar_today,
                borderSide: BorderSide(),
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                fieldName: 'Password',
                fieldNameColor: customTeksColorDark,
                hintText: 'Password',
                isPassword: true,
                suffixIcon: Icons.visibility_off,
                borderSide: BorderSide(),
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                fieldName: 'Confirm Password',
                fieldNameColor: customTeksColorDark,
                hintText: 'Confirm Password',
                isPassword: true,
                suffixIcon: Icons.visibility_off,
                borderSide: BorderSide(),
              ),
              const SizedBox(height: 24),
              CustomButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                text: 'Create Account',
                backgroundColor: customButtonColorDark,
                textColor: customTeksColorLight,
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have account?",
                      style: TextStyle(color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                            color: Color(0xFF5751F7),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
