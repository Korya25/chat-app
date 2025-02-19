import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';

class HiveService {
  static const String _boxName = 'authBox';

  // Save user credentials
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    var box = await Hive.openBox(_boxName);
    await box.put('user', userData);
  }

  // Get user ID
  static Future<UserModel?> getUserId() async {
    var box = await Hive.openBox(_boxName);
    var data = box.get('user');
    return data != null ? UserModel.fromHiveMap(data) : null;
  }

  // Get email
  static Future<UserModel?> getEmail() async {
    var box = await Hive.openBox(_boxName);
    var data = box.get('user');
    return data != null ? data['email'] : null;
  }

  // Get user name
  static Future<UserModel?> getUserName() async {
    var box = await Hive.openBox(_boxName);
    var data = box.get('user');
    return data != null ? data['userName'] : null;
  }

  // Get user data
  static Future<UserModel?> getUserData() async {
    var box = await Hive.openBox(_boxName);
    var data = box.get('user');
    return data != null ? UserModel.fromHiveMap(data) : null;
  }

  // Check if user is logged in
  static Future<bool> isUserLoggedIn() async {
    var box = await Hive.openBox(_boxName);
    return box.containsKey('user');
  }

  // Clear user data (Logout)
  static Future<void> clearUserData() async {
    var box = await Hive.openBox(_boxName);
    await box.clear();
  }
}
