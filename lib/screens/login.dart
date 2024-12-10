import 'package:filmify/screens/bottom_nav_bar.dart';
import 'package:filmify/screens/register.dart';
import 'package:filmify/utils/colors.dart';
import 'package:filmify/utils/image.dart';
import 'package:filmify/widgets/custom_button.dart';
import 'package:filmify/widgets/custom_card.dart';
import 'package:filmify/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:filmify/services/auth_service.dart'; // Import AuthService

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _authService = AuthService(); // Instance of AuthService
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in both email and password.';
      });
      return;
    }

    try {
      final user = await _authService.loginWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (user != null) {
        // Navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()),
        );
      } else {
        setState(() {
          _errorMessage = 'Failed to log in. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
    }
  }

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
        backgroundColor: const Color.fromARGB(255, 253, 253, 253),
        borderRadius: 20.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Login to Filmify',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: customTeksColorDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email",
                style: TextStyle(
                  fontSize: 16,
                  color: customTeksColorDark, // Gunakan parameter warna
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "example@example.com",
                hintStyle: const TextStyle(color: Colors.black45),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password",
                style: TextStyle(
                  fontSize: 16,
                  color: customTeksColorDark, // Gunakan parameter warna
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Enter your password",
                hintStyle: const TextStyle(color: Colors.black45),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
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
                  style: TextStyle(color: Color.fromARGB(179, 20, 20, 20)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: _login, // Call the login function
              text: 'Login',
              backgroundColor: customButtonColorDark,
              textColor: customTeksColorLight,
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Color.fromARGB(179, 24, 23, 23)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      color: Color(0xFF5751F7),
                      fontWeight: FontWeight.bold,
                    ),
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
