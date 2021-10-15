import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shopping_cart/Firebase/Firestore.dart';
import 'package:shopping_cart/Model/User.dart';
import 'package:shopping_cart/Screens/Chat/ChatScreen.dart';
import 'package:shopping_cart/Screens/Chat/MessageScreen.dart';
import 'package:shopping_cart/Screens/HomeScreen.dart';
import 'package:shopping_cart/main.dart';

class FeedScreen extends StatefulWidget {
  final String currentUserId;
  const FeedScreen({
    Key? key,
    required this.currentUserId,
  }) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedTab = 0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /*getToken()メソッドを必ず実行しないとプッシュ通知が送れない*/
  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print('device token: $deviceToken');
    });
  }

  getProfileAndNavigate({
    required String convoId,
    required String currentUserId,
    required String peerUserId,
  }) async {
    /*ユーザー自身のプロフィール*/
    DocumentSnapshot userProfileDoc =
        await Firestore().getUserProfile(userId: currentUserId);
    User currentUser = User.fromDoc(userProfileDoc);
    /*相手ユーザーのプロフィール*/
    DocumentSnapshot peerUserProfileDoc =
        await Firestore().getUserProfile(userId: peerUserId);
    User peerUser = User.fromDoc(peerUserProfileDoc);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          convoId: convoId,
          currentUser: currentUser,
          peerUser: peerUser,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getToken();

    //ターミネイト用
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print("ターミネイトでメッセージを受け取りました！");
        Map<String, dynamic> data = message.data;
        String _convoId = jsonDecode(data['convoId']);
        String _senderId = jsonDecode(data['senderId']);
        String _receiverId = jsonDecode(data['receiverId']);
        String _senderProfileImage = jsonDecode(data['senderProfileImage']);
        print('convoId: $_convoId');
        print('senderId: $_senderId');
        print('receiverId: $_receiverId');

        if (_senderId == widget.currentUserId) {
          getProfileAndNavigate(
            convoId: _convoId,
            currentUserId: _senderId,
            peerUserId: _receiverId,
          );
          print('ChatScreenに遷移しました！');
        } else if (_senderId != widget.currentUserId) {
          getProfileAndNavigate(
            convoId: _convoId,
            currentUserId: _receiverId,
            peerUserId: _senderId,
          );
          print('ChatScreenに遷移しました...');
        }
      }
    });

    //フォアグラウンド用
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("フォアグラウンドでメッセージを受け取りました！");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              //icon: 'launch_background',
              icon: 'shopping_cart',
            ),
          ),
        );
      }
    });

    /*バックグラウンド用*/
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("バックグラウンドでメッセージを受け取りました！");
      Map<String, dynamic> data = message.data;
      String _convoId = jsonDecode(data['convoId']);
      String _senderId = jsonDecode(data['senderId']);
      String _receiverId = jsonDecode(data['receiverId']);
      print('convoId: $_convoId');
      print('senderId: $_senderId');
      print('receiverId: $_receiverId');

      if (_senderId == widget.currentUserId) {
        getProfileAndNavigate(
          convoId: _convoId,
          currentUserId: _senderId,
          peerUserId: _receiverId,
        );
        print('ChatScreenに遷移しました！');
      } else if (_senderId != widget.currentUserId) {
        getProfileAndNavigate(
          convoId: _convoId,
          currentUserId: _receiverId,
          peerUserId: _senderId,
        );
        print('ChatScreenに遷移しました...');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeScreen(currentUserId: widget.currentUserId),
        MessageScreen(currentUserId: widget.currentUserId),
      ].elementAt(_selectedTab),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        activeColor: Colors.blue,
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.chat)),
        ],
      ),
    );
  }
}
