import 'package:chat_app/features/account/data/accouont_hive_services.dart';
import 'package:chat_app/features/auth/data/services/hive_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ✅ Delete user account from Firebase, Firestore, and Hive
  Future<void> deleteUserAccount(String password) async {
    User? user = _auth.currentUser;
    String email = user?.email ?? '';

    if (user != null && email == user.email) {
      try {
        // 🔹 Re-authenticate user before deletion
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);

        // 🔹 Delete user data from Firestore
        await _firestore.collection('users').doc(user.uid).delete();

        // 🔹 Delete user from Firebase Authentication
        await user.delete();

        // 🔹 Delete user data from Hive
        await AccountHiveService.deleteUser(user.email!);

        // 🔹 Sign out user and clear Hive data
        await _auth.signOut();
        await HiveService.clearUserData();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          throw Exception("Incorrect password. Please try again.");
        } else if (e.code == 'user-mismatch') {
          throw Exception("User does not match the email.");
        } else if (e.code == 'requires-recent-login') {
          throw Exception("Please log in again before deleting the account.");
        }
        throw Exception("Failed to delete account: ${e.message}");
      } catch (e) {
        throw Exception("Unexpected error: $e");
      }
    } else {
      throw Exception("Email does not match the current account.");
    }
  }

  // ✅ Update user password in Firebase and Hive
  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
            code: 'user-not-found', message: 'No user logged in.');
      }

      // 🔹 Re-authenticate user before password update
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // 🔹 Update password in Firebase
      await user.updatePassword(newPassword);

      // 🔹 Update password in Hive
      AccountHiveService.updatePassword(user.email!, newPassword);

      print("✅ Password updated successfully.");
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseError(e));
    }
  }

  // ✅ Request email verification before updating email
  Future<bool> requestEmailVerification(
      String newEmail, String currentPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) throw Exception("No user logged in.");

      // 🔹 Re-authenticate user
      bool isAuthenticated = await reAuthenticateUser(currentPassword);
      if (!isAuthenticated) return false;

      // 🔹 Send verification email to the new email address
      await user.verifyBeforeUpdateEmail(newEmail);
      print(
          "✅ Verification email sent to $newEmail. Please verify before changing.");

      return true;
    } catch (e) {
      print("❌ Email verification request failed: $e");
      return false;
    }
  }

  // ✅ Confirm and update email after verification
  Future<bool> confirmAndUpdateEmail(String newEmail) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("No user logged in.");

      if (!isEmailVerified()) throw Exception("Email not verified yet.");

      // 🔹 Update email in Firebase
      await user.updateEmail(newEmail);

      // 🔹 Update email in Firestore
      await updateUserEmailInFirestore(user.uid, newEmail);

      // 🔹 Update email in Hive
      await AccountHiveService().updateEmailInHive(newEmail);

      print("✅ Email updated successfully.");
      return true;
    } catch (e) {
      print("❌ Failed to update email after verification: $e");
      return false;
    }
  }

  // ✅ Re-authenticate user before sensitive operations
  Future<bool> reAuthenticateUser(String currentPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      return true;
    } catch (e) {
      print("❌ Re-authentication failed: $e");
      return false;
    }
  }

  // ✅ Check if user has verified their email
  bool isEmailVerified() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.emailVerified ?? false;
  }

  // ✅ Update email in Firestore
  Future<void> updateUserEmailInFirestore(
      String userId, String newEmail) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'email': newEmail,
    });
  }

  // ✅ Handle Firebase authentication errors
  String _handleFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'wrong-password':
        return 'Incorrect old password.';
      case 'weak-password':
        return 'The new password is too weak.';
      case 'requires-recent-login':
        return 'Please log in again to update your password.';
      default:
        return 'An unexpected error occurred.';
    }
  }

  Future<void> updateUsername(String newUsername) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception("No user is logged in.");
      }

      // Update Firestore
      await _firestore.collection('users').doc(user.uid).update({
        'userName': newUsername,
      });

      // Update Hive
      await AccountHiveService().updateUsernameInHive(newUsername);
    } catch (e) {
      throw Exception("Username update failed: ${e.toString()}");
    }
  }
}
