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

  /*チャット関連*/
  Future<void> addChat({
    required String currentUserId,
    required String chatText,
  }) async {
    DocumentReference chatReference = chatsRef.doc();
    await chatReference.set({
      'chatId': chatReference.id,
      'userId': currentUserId,
      'text': chatText,
      'timestamp': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> deleteChat({
    required String chatId,
  }) async {
    await chatsRef.doc(chatId).delete();
  }
}
