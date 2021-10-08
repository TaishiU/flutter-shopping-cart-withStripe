import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String chatId;
  String userId;
  String text;
  Timestamp timestamp;

  Chat({
    required this.chatId,
    required this.userId,
    required this.text,
    required this.timestamp,
  });

  factory Chat.fromDoc(DocumentSnapshot doc) {
    return Chat(
      chatId: doc['chatId'],
      userId: doc['userId'],
      text: doc['text'],
      timestamp: doc['timestamp'],
    );
  }
}
