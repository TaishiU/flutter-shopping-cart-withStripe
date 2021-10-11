import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/Constants/Constants.dart';

class Firestore {
  /*プロフィール関連*/
  Future<void> registerUser({
    required String userId,
    required String name,
    required String email,
    required String? fcmToken,
  }) async {
    DocumentReference usersReference = usersRef.doc(userId);
    await usersReference.set({
      'userId': usersReference.id,
      'name': name,
      'email': email,
      'fcmToken': fcmToken,
    });
  }

  Future<DocumentSnapshot> getUserProfile({
    required String userId,
  }) async {
    DocumentSnapshot userProfileDoc = await usersRef.doc(userId).get();
    return userProfileDoc;
  }

  Future<void> addChat({
    required String convoId,
    required String currentUserId,
    required String currentUserName,
    required String peerUserId,
    required String chatText,
  }) async {
    DocumentReference chatReference =
        chatsRef.doc(convoId).collection('message').doc();
    await chatReference.set({
      'chatId': chatReference.id,
      'text': chatText,
      'senderId': currentUserId,
      'senderName': currentUserName,
      'receiverId': peerUserId,
      'convoId': convoId,
      'timestamp': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> deleteChat({
    required String chatId,
    required String convoId,
  }) async {
    await chatsRef.doc(convoId).collection('message').doc(chatId).delete();
  }
}
