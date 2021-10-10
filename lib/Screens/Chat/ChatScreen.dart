import 'package:flutter/material.dart';
import 'package:shopping_cart/Firebase/Auth.dart';
import 'package:shopping_cart/Screens/Chat/SelectUserScreen.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  ChatScreen({
    Key? key,
    required this.currentUserId,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  String chatText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
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
      // body: Stack(
      //   children: [
      //     StreamBuilder(
      //       stream: FirebaseFirestore.instance
      //           .collection('chats')
      //           .orderBy('timestamp', descending: false)
      //           .snapshots(),
      //       builder:
      //           (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //         if (!snapshot.hasData) {
      //           return Center(
      //             child: CircularProgressIndicator(),
      //           );
      //         }
      //         final List<DocumentSnapshot> documents = snapshot.data!.docs;
      //         return ListView(
      //           physics: BouncingScrollPhysics(
      //             parent: AlwaysScrollableScrollPhysics(),
      //           ),
      //           children: documents.map((document) {
      //             //Chat chat = Chat.fromDoc(document);
      //             // return ChatContainer(
      //             //   currentUserId: widget.currentUserId,
      //             //   chat: chat,
      //             // );
      //             return Container();
      //           }).toList(),
      //         );
      //       },
      //     ),
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: Container(
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           border: Border(
      //             top: BorderSide(
      //               color: Colors.grey.shade200,
      //               width: 1,
      //             ),
      //           ),
      //         ),
      //         child: Padding(
      //           padding:
      //               EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               Container(
      //                 height: 40,
      //                 width: MediaQuery.of(context).size.width * 0.7,
      //                 decoration: BoxDecoration(
      //                   color: Colors.grey.shade100,
      //                   borderRadius: BorderRadius.circular(20),
      //                 ),
      //                 child: TextFormField(
      //                   controller: textEditingController,
      //                   keyboardType: TextInputType.multiline,
      //                   maxLines: null,
      //                   decoration: InputDecoration(
      //                     contentPadding: EdgeInsets.only(left: 12, bottom: 11),
      //                     border: InputBorder.none,
      //                   ),
      //                   onChanged: (input) {
      //                     setState(() {
      //                       chatText = input;
      //                     });
      //                   },
      //                   focusNode: _focusNode,
      //                 ),
      //               ),
      //               GestureDetector(
      //                 onTap: () {
      //                   Firestore().addChat(
      //                     currentUserId: widget.currentUserId,
      //                     chatText: chatText,
      //                   );
      //                   textEditingController.clear();
      //                   _focusNode.unfocus();
      //                 },
      //                 child: Icon(
      //                   Icons.send_rounded,
      //                   color: Colors.blue,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: Center(child: Text('Chat')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectUserScreen(
                      currentUserId: widget.currentUserId,
                    )),
          );
        },
      ),
    );
  }
}
