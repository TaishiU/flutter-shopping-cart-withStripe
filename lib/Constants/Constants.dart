import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final usersRef = _firestore.collection('users');
final nikeRef = _firestore.collection('Nike');
final adidasRef = _firestore.collection('Adidas');
final pumaRef = _firestore.collection('Puma');
final newBalanceRef = _firestore.collection('New Balance');
