import 'package:hive/hive.dart';

class AccountHiveService {
  // حذف بيانات المستخدم من Hive
  static Future<void> deleteUser(String userId) async {
    final box = await Hive.openBox('authBox');
    await box.delete(userId);
  }

  // Update password in Hive
  static Future<void> updatePassword(String userId, String newPassword) async {
    final box = await Hive.openBox('authBox');
    await box.put(userId, newPassword);
  }

  // change email in Hive
  Future<void> updateEmailInHive(String newEmail) async {
    var box = await Hive.openBox('userBox');
    box.put('email', newEmail);
  }

  Future<void> updateUsernameInHive(String newUsername) async {
    var userBox = await Hive.openBox('userBox');
    await userBox.put('username', newUsername);
  }
}
