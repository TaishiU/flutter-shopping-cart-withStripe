import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/Firebase/Auth.dart';
import 'package:shopping_cart/Firebase/Firestore.dart';
import 'package:shopping_cart/Model/Chat.dart';
import 'package:shopping_cart/Widget/ChatContainer.dart';

class ChatScreen extends StatefulWidget {
  final String convoId;
  final String currentUserId;
  final String currentUserName;
  final String peerUserId;

  ChatScreen({
    Key? key,
    required this.convoId,
    required this.currentUserId,
    required this.currentUserName,
    required this.peerUserId,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String chatText;
  TextEditingController textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              Auth().logout();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chats')
                .doc(widget.convoId)
                .collection('message')
                .orderBy('timestamp', descending: false)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ListView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: documents.map((document) {
                  Chat chat = Chat.fromDoc(document);
                  return ChatContainer(
                    currentUserId: widget.currentUserId,
                    chat: chat,
                  );
                }).toList(),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        controller: textEditingController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 12, bottom: 11),
                          border: InputBorder.none,
                        ),
                        onChanged: (input) {
                          setState(() {
                            chatText = input;
                          });
                        },
                        focusNode: _focusNode,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Firestore().addChat(
                          convoId: widget.convoId,
                          currentUserId: widget.currentUserId,
                          currentUserName: widget.currentUserName,
                          peerUserId: widget.peerUserId,
                          chatText: chatText,
                        );
                        textEditingController.clear();
                        _focusNode.unfocus();
                      },
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
