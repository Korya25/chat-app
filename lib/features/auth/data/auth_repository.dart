import 'package:chat_app/features/auth/data/hive_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Sign In
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await HiveService.saveUserData(credential.user!.uid, email);
      }

      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  // Sign Up
  Future<User?> signUp({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await HiveService.saveUserData(credential.user!.uid, email);

        // Add user to Firestore
        await _addUserToFirestore(
          userId: credential.user!.uid,
          email: email,
          userName: userName,
        );
      }

      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await HiveService.clearUserData();
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    // ignore: deprecated_member_use
    final signInMethods = await _firebaseAuth.fetchSignInMethodsForEmail(email);

    if (signInMethods.isEmpty) {
      throw Exception("Email is not registered");
    }

    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Check if user is already logged in
  Future<bool> isUserLoggedIn() {
    return HiveService.isUserLoggedIn();
  }

  // Add user to Firestore
  Future<void> _addUserToFirestore({
    required String userId,
    required String email,
    required String userName,
  }) async {
    try {
      await _firestore.collection("users").doc(userId).set({
        "userId": userId,
        "email": email,
        "userName": userName,
        "createdAt": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Failed to add user to Firestore: ${e.toString()}");
    }
  }
}
