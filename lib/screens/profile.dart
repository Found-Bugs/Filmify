import 'package:filmify/screens/change_password.dart';
import 'package:filmify/utils/colors.dart';
import 'package:filmify/widgets/custom_button.dart';
import 'package:filmify/widgets/custom_menu_profile.dart';
import 'package:filmify/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 45.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Profile Picture
            CircleAvatar(
              radius:
                  screenWidth * 0.17, // Ukuran disesuaikan dengan lebar layar
              backgroundColor: const Color(0xFFC4C4C4),
              child: const Icon(Icons.person, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Input Fields
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
            const SizedBox(height: 30),
            CustomButton(
              onPressed: () {},
              text: 'Update',
              backgroundColor: customButtonColorDark,
              textColor: customTeksColorLight,
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Other",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            CustomMenuProfile(
                icon: Icons.lock,
                text: 'Change Password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePassword()),
                  );
                }),
            CustomMenuProfile(
                icon: Icons.logout,
                text: 'Logout',
                textColor: Colors.red,
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}
