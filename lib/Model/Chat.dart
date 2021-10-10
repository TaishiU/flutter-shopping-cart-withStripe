import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String chatId;
  String text;
  String senderId;
  String senderName;
  String receiverId;
  String convoId;
  Timestamp timestamp;

  Chat({
    required this.chatId,
    required this.text,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.convoId,
    required this.timestamp,
  });

  factory Chat.fromDoc(DocumentSnapshot doc) {
    return Chat(
      chatId: doc['chatId'],
      text: doc['text'],
      senderId: doc['senderId'],
      senderName: doc['senderName'],
      receiverId: doc['receiverId'],
      convoId: doc['convoId'],
      timestamp: doc['timestamp'],
    );
  }
}
