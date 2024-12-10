import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:filmify/screens/change_password.dart';
import 'package:filmify/screens/login.dart';
import 'package:filmify/utils/colors.dart';
import 'package:filmify/widgets/custom_button.dart';
import 'package:filmify/widgets/custom_menu_profile.dart';
import 'package:flutter/material.dart';
import 'package:filmify/services/auth_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  String username = '';
  String email = '';
  String age = '';

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        username = userDoc['username'];
        email = userDoc['email'];
        age = userDoc['age'].toString();
        _usernameController.text = username;
        _ageController.text = age;
      });
    }
  }

  Future<void> _updateUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      Map<String, dynamic> updatedData = {};
      if (_usernameController.text.isNotEmpty) {
        updatedData['username'] = _usernameController.text;
      }
      if (_ageController.text.isNotEmpty) {
        updatedData['age'] = _ageController.text;
      }

      if (updatedData.isNotEmpty) {
        await _authService.updateUserProfile(user.uid, updatedData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No changes to update')),
        );
      }
    }
  }

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

            // Input Fields
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Username",
                style: TextStyle(
                  fontSize: 16,
                  color: customTeksColorDark,
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _usernameController,
              style: const TextStyle(
                color: Colors.black, // Black color when typing
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: username,
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
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
                "Email",
                style: TextStyle(
                  fontSize: 16,
                  color: customTeksColorDark,
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              enabled: false,
              style: const TextStyle(
                color: Colors.black, // Black color when typing
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: email,
                hintStyle: const TextStyle(
                  color: Colors.grey, // Lighter color to indicate non-editable
                  fontWeight: FontWeight.bold,
                ),
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
                "Age",
                style: TextStyle(
                  fontSize: 16,
                  color: customTeksColorDark,
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _ageController,
              style: const TextStyle(
                color: Colors.black, // Black color when typing
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: age,
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              onPressed: _updateUserProfile,
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
