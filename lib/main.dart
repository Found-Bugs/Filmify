import 'package:filmify/screens/favorite.dart';
import 'package:filmify/screens/genres.dart';
import 'package:filmify/screens/home.dart';
import 'package:filmify/screens/login.dart';
import 'package:filmify/screens/profile.dart';
import 'package:filmify/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      title: "Filmify",
    );
  }
}
