import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Pastikan path ini benar

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register a user with email and password
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Registration error: ${e.message}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  // Login a user with email and password
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      } else {
        print('Login error: ${e.message}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  // Logout the current user
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Update user profile information
  Future<void> updateUserProfile(
      String uid, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('users').doc(uid).update(updatedData);
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  // Save prediction result and image URL to Firestore
  Future<void> savePredictionToHistory(String userId, String imageUrl, Map<String, dynamic> prediction) async {
    try {
      await _firestore.collection('users').doc(userId).collection('history').add({
        'image_url': imageUrl,
        'prediction': prediction,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving prediction to history: $e');
    }
  }

  // Fetch prediction history for the current user
  Future<List<Map<String, dynamic>>> fetchPredictionHistory(String userId) async {
    try {
      final snapshot = await _firestore.collection('users').doc(userId).collection('history').orderBy('timestamp', descending: true).get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error fetching prediction history: $e');
      return [];
    }
  }
}
