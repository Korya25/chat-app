import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String email;
  final String userName;
  final DateTime? createdAt;

  UserModel({
    required this.userId,
    required this.email,
    required this.userName,
    this.createdAt,
  });

  // تحويل من Map<String, dynamic>
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      email: map['email'],
      userName: map['userName'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  // تحويل من Firestore
  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      userId: data['userId'],
      email: data['email'],
      userName: data['userName'],
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  // تحويل إلى Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'userName': userName,
      'createdAt': createdAt,
    };
  }

  // تحويل إلى Hive Map (للتخزين في Hive)
  factory UserModel.fromHiveMap(Map<dynamic, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      email: map['email'] as String,
      userName: map['userName'] as String,
      createdAt: map['createdAt'] as DateTime?,
    );
  }

  Map<String, dynamic> toHiveMap() {
    return {
      'userId': userId,
      'email': email,
      'userName': userName,
      'createdAt': createdAt,
    };
  }
}
