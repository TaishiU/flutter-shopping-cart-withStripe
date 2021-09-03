import 'package:flutter/material.dart';
import 'package:shopping_cart/Screens/HomeScreen.dart';

class SuccessPayScreen extends StatelessWidget {
  final String totalResult;
  SuccessPayScreen({Key? key, required this.totalResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.orange,
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                    ),
                    Icon(
                      Icons.check,
                      size: 80,
                      color: Colors.orange,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'お支払いが完了しました！',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  //color: Colors.red,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'お支払い金額:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '¥$totalResult',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  child: Center(
                    child: Text(
                      '買い物を続ける',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                        (_) => false);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
