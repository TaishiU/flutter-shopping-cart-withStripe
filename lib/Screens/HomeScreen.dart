import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_cart/Constants/Constants.dart';
import 'package:shopping_cart/Screens/PaymentScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List shoesCartList = []; /*カートに入れた商品リスト*/

  @override
  Widget build(BuildContext context) {
    // // アスペクト比を計算する
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 320) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Shoes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.orange,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PaymentScreen(shoesCartList: shoesCartList),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: StreamBuilder<QuerySnapshot>(
            stream: nikeRef.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<DocumentSnapshot> nikeShoes = snapshot.data!.docs;
              return GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: (itemWidth / itemHeight),
                children: nikeShoes.map((shoesSnap) {
                  final formatter = NumberFormat('#,###');
                  var price = formatter.format(shoesSnap['price']);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          image: DecorationImage(
                            image: NetworkImage(shoesSnap['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        shoesSnap['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        shoesSnap['gender'],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('¥$price'),
                          IconButton(
                            icon: Icon(Icons.shopping_cart_outlined),
                            color: Colors.orange,
                            onPressed: () {
                              shoesCartList.add(shoesSnap.data());
                              print(shoesCartList);
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
