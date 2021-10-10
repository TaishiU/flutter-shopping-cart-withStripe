import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String fcmToken;
  String name;
  String userId;

  User({
    required this.email,
    required this.fcmToken,
    required this.name,
    required this.userId,
  });

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      email: doc['email'],
      fcmToken: doc['fcmToken'],
      name: doc['name'],
      userId: doc['userId'],
    );
  }
}
