import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

  @override
  void initState() {
    super.initState();
    _getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("フォアグラウンドでメッセージを受け取りました");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      print('messageData: ${message.data}');
      print('message.senderId: ${message.senderId}');

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
                icon: 'launch_background',
              ),
            ));
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
