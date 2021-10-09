import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopping_cart/Riverpod.dart';
import 'package:shopping_cart/Screens/ChatScreen.dart';
import 'package:shopping_cart/Screens/HomeScreen.dart';

class FeedScreen extends HookWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomTab = useProvider(bottomTabProvider);

    return Scaffold(
      body: [
        HomeScreen(),
        ChatScreen(),
      ].elementAt(bottomTab),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          context.read(bottomTabProvider.notifier).update(index);
        },
        activeColor: Colors.blue,
        currentIndex: bottomTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.chat)),
        ],
      ),
    );
  }
}
