import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String fcmToken;
  String name;
  String userId;
  String profileImage;

  User({
    required this.email,
    required this.fcmToken,
    required this.name,
    required this.userId,
    required this.profileImage,
  });

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      email: doc['email'],
      fcmToken: doc['fcmToken'],
      name: doc['name'],
      userId: doc['userId'],
      profileImage: doc['profileImage'],
    );
  }
}
