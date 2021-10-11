import 'package:flutter/material.dart';
import 'package:shopping_cart/Firebase/Firestore.dart';
import 'package:shopping_cart/Model/Chat.dart';

class ChatContainer extends StatelessWidget {
  final String currentUserId;
  final Chat chat;
  ChatContainer({
    Key? key,
    required this.currentUserId,
    required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (chat.senderId == currentUserId) {
      /*ユーザー自身のメッセージは右側に表示*/
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onLongPress: () {
              /*長押しでメッセージ削除のアラートを出す*/
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Delete message'),
                    content: Text('Do you want to delete this message?'),
                    actions: [
                      TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.red,
                        ),
                        onPressed: () {
                          Firestore().deleteChat(
                            chatId: chat.chatId,
                            convoId: chat.convoId,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.only(right: 20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                  color: Color(0xff00acee),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Text(
                  chat.text,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (chat.senderId != currentUserId) {
      /*相手ユーザーのメッセージは左側に表示*/
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.only(left: 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                chat.text,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Text(
              'chat container error!',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
