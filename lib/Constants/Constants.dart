import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final usersRef = _firestore.collection('users');
final chatsRef = _firestore.collection('chats');
final nikeRef = _firestore.collection('Nike');
