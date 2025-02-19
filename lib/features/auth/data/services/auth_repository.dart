import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/auth/data/services/hive_service.dart';
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
  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        // Retrieve user data from Firestore
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .get();
        if (userDoc.exists) {
          UserModel user =
              UserModel.fromFirestore(userDoc.data() as Map<String, dynamic>);
          // Save user data to Hive
          await HiveService.saveUserData(user.toHiveMap());

          return user;
        }
      }

      return null;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  Future<void> sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      print('✅ Verification email sent!');
    } else {
      print('⚠️ User is null or already verified.');
    }
  }

  // Sign Up
  Future<UserModel?> signUp({
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
        UserModel user = UserModel(
          userId: credential.user!.uid,
          email: email,
          userName: userName,
          createdAt: DateTime.now(),
        );
        sendVerificationEmail();
        await _addUserToFirestore(user: user);
        await HiveService.saveUserData(user.toHiveMap());

        return user;
      }

      return null;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await HiveService.clearUserData();
    } catch (e) {
      throw Exception("Failed to log out: ${e.toString()}");
    }
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
      final signInMethods =
          // ignore: deprecated_member_use
          await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (signInMethods.isEmpty) {
        throw FirebaseAuthException(
          code: "user-not-found",
          message: "Email is not registered",
        );
      }

      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception("Firebase error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  // Check if user is already logged in
  Future<bool> isUserLoggedIn() {
    return HiveService.isUserLoggedIn();
  }

  // Add user to Firestore
  Future<void> _addUserToFirestore({required UserModel user}) async {
    try {
      await _firestore.collection('users').doc(user.userId).set(user.toMap());
    } catch (e) {
      throw Exception("Failed to add user to Firestore: ${e.toString()}");
    }
  }

  // Get user from Hive
  Future<UserModel?> getUserFromHive() async {
    return await HiveService.getUserData();
  }
}
