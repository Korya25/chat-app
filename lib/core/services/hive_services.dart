import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';

class HiveService {
  static const String _boxName = 'authBox';

  // Save user credentials
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    var box = await Hive.openBox(_boxName);
    await box.put('user', userData);
  }

  // Get user ID
  Future<UserModel?> getUserId() async {
    var box = await Hive.openBox(_boxName);
    var data = box.get('user');
    return data != null ? UserModel.fromHiveMap(data) : null;
  }

  // Get email
  Future<UserModel?> getEmail() async {
    var box = await Hive.openBox(_boxName);
    var data = box.get('user');
    return data != null ? data['email'] : null;
  }

  // Get user name
  Future<UserModel?> getUserName() async {
    var box = await Hive.openBox(_boxName);
    var data = box.get('user');
    return data != null ? data['userName'] : null;
  }

  // Get user data
  Future<UserModel?> getUserData() async {
    var box = await Hive.openBox(_boxName);
    var data = box.get('user');
    return data != null ? UserModel.fromHiveMap(data) : null;
  }

  // Check if user is logged in
  Future<bool> isUserLoggedIn() async {
    var box = await Hive.openBox(_boxName);
    return box.containsKey('user');
  }

  // Clear user data (Logout)
  Future<void> clearUserData() async {
    var box = await Hive.openBox(_boxName);
    await box.clear();
  }

  //  Delete user from Hive
  Future<void> deleteUser(String userId) async {
    final box = await Hive.openBox(_boxName);
    await box.delete(userId);
  }

  // Update password in Hive
  Future<void> updatePassword(String userId, String newPassword) async {
    final box = await Hive.openBox(_boxName);
    await box.put(userId, newPassword);
  }

  // change email in Hive
  Future<void> updateEmailInHive(String newEmail) async {
    var box = await Hive.openBox(_boxName);
    box.put('email', newEmail);
  }

  // change username in Hive
  Future<void> updateUsernameInHive(String newUsername) async {
    var userBox = await Hive.openBox(_boxName);
    await userBox.put('username', newUsername);
  }

  // ✅ تحديث صورة الملف الشخصي
  Future<void> updateProfilePicture(String userId, String imagePath) async {
    try {
      final box = await Hive.openBox(_boxName);
      final user = box.get(userId);

      if (user != null) {
        user.profilePicture = imagePath;
        await box.put(userId, user);
      }
    } catch (e) {
      throw Exception("Failed to update profile picture: $e");
    }
  }

  // ✅ حذف صورة الملف الشخصي
  Future<void> deleteProfilePicture(String userId) async {
    try {
      final box = await Hive.openBox(_boxName);
      final user = box.get(userId);

      if (user != null) {
        user.profilePicture = null;
        await box.put(userId, user);
      }
    } catch (e) {
      throw Exception("Failed to delete profile picture: $e");
    }
  }
}
