import 'package:hive/hive.dart';

class HiveService {
  static const String _boxName = 'authBox';

  // Save user credentials
  static Future<void> saveUserData(String userId, String email) async {
    var box = await Hive.openBox(_boxName);
    await box.put('userId', userId);
    await box.put('email', email);
  }

  // Get user ID
  static Future<String?> getUserId() async {
    var box = await Hive.openBox(_boxName);
    return box.get('userId');
  }

  // Get email
  static Future<String?> getEmail() async {
    var box = await Hive.openBox(_boxName);
    return box.get('email');
  }

  // Check if user is logged in
  static Future<bool> isUserLoggedIn() async {
    var box = await Hive.openBox(_boxName);
    return box.containsKey('userId');
  }

  // Clear user data (Logout)
  static Future<void> clearUserData() async {
    var box = await Hive.openBox(_boxName);
    await box.clear();
  }
}
