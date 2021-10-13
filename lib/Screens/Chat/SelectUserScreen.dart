import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/Constants/Constants.dart';
import 'package:shopping_cart/Firebase/Firestore.dart';
import 'package:shopping_cart/Model/User.dart';
import 'package:shopping_cart/Screens/Chat/ChatScreen.dart';
import 'package:shopping_cart/Utils/HelperFunctions.dart';

class SelectUserScreen extends StatefulWidget {
  final String currentUserId;
  SelectUserScreen({
    Key? key,
    required this.currentUserId,
  }) : super(key: key);

  @override
  _SelectUserScreenState createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
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
          'Select User',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: usersRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<DocumentSnapshot> usersList = snapshot.data!.docs;
          usersList.removeWhere(
              (snapshot) => snapshot.get('userId') == widget.currentUserId);
          return ListView(
            children: usersList.map((userSnap) {
              User peerUser = User.fromDoc(userSnap);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GestureDetector(
                  onTap: () async {
                    /*ユーザー自身のプロフィール*/
                    DocumentSnapshot userProfileDoc = await Firestore()
                        .getUserProfile(userId: widget.currentUserId);
                    User currentUser = User.fromDoc(userProfileDoc);
                    /*会話Id（トークルームのId）を取得する*/
                    String convoId = HelperFunctions.getConvoIDFromHash(
                      currentUserId: widget.currentUserId,
                      currentUserName: currentUser.name,
                      peerUserId: peerUser.userId,
                      peerUserName: peerUser.name,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          convoId: convoId,
                          currentUser: currentUser,
                          peerUserId: peerUser.userId,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.yellow,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 23,
                            backgroundImage:
                                NetworkImage(peerUser.profileImage),
                          ),
                          SizedBox(width: 30),
                          Text(
                            peerUser.name,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
