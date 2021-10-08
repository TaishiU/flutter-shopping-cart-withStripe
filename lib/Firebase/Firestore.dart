import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/Constants/Constants.dart';

class Firestore {
  /*プロフィール関連*/
  Future<void> registerUser({
    required String userId,
    required String email,
  }) async {
    DocumentReference usersReference = usersRef.doc(userId);
    await usersReference.set({
      'userId': usersReference.id,
      'email': email,
    });
  }
}
