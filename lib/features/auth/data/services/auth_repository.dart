import 'package:chat_app/core/services/hive_services.dart';
import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final HiveService _hiveService = HiveService();

  User? getCurrentUser() => _firebaseAuth.currentUser;

  /// ✅ Signs in a user with email and password
  /// - Fetches user data from Firestore if login is successful
  /// - Saves the user data in Hive for local access
  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        return await _fetchAndCacheUserData(credential.user!.uid);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  /// ✅ Registers a new user with email, password, and username
  /// - Saves user data to Firestore and Hive
  /// - Sends an email verification link
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

        await sendVerificationEmail();
        await _addUserToFirestore(user);
        await _hiveService.saveUserData(user.toHiveMap());

        return user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  /// ✅ Logs out the current user
  /// - Signs the user out from Firebase
  /// - Clears user data from Hive
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _hiveService.clearUserData();
    } catch (e) {
      throw Exception("Failed to log out: ${e.toString()}");
    }
  }

  /// ✅ Sends a password reset email if the email exists in Firebase Auth
  Future<void> resetPassword(String email) async {
    try {
      final signInMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (signInMethods.isEmpty) {
        throw FirebaseAuthException(
            code: "user-not-found", message: "Email is not registered");
      }
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception("Firebase error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  /// ✅ Checks if the user is already logged in (by checking Hive storage)
  Future<bool> isUserLoggedIn() => _hiveService.isUserLoggedIn();

  /// ✅ Sends an email verification link to the logged-in user
  Future<void> sendVerificationEmail() async {
    final user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  /// ✅ Saves the user data in Firestore
  Future<void> _addUserToFirestore(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.userId).set(user.toMap());
    } catch (e) {
      throw Exception("Failed to add user to Firestore: ${e.toString()}");
    }
  }

  /// ✅ Retrieves user data from Hive storage
  Future<UserModel?> getUserFromHive() async =>
      await _hiveService.getUserData();

  /// ✅ Fetches user data from Firestore and saves it in Hive for local access
  Future<UserModel?> _fetchAndCacheUserData(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        UserModel user =
            UserModel.fromFirestore(userDoc.data() as Map<String, dynamic>);
        await _hiveService.saveUserData(user.toHiveMap());
        return user;
      }
      return null;
    } catch (e) {
      throw Exception("Failed to fetch user data: ${e.toString()}");
    }
  }
}
