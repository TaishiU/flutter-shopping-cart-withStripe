import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/Constants/Constants.dart';
import 'package:shopping_cart/Screens/PaymentScreen.dart';

class HomScreen extends StatefulWidget {
  const HomScreen({Key? key}) : super(key: key);

  @override
  _HomScreenState createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {
  final List shoesCartList = []; /*カートに入れた商品リスト*/

  // Map group = {
  //   0: {
  //     'brand': 'Nike',
  //     'logo':
  //         'https://freepngimg.com/thumb/nike_logo/6-2-nike-logo-free-png-image-thumb.png'
  //   },
  //   1: {
  //     'brand': 'Adidas',
  //     'logo':
  //         'https://upload.wikimedia.org/wikipedia/commons/2/24/Adidas_logo.png'
  //   },
  //   2: {
  //     'brand': 'Puma',
  //     'logo': 'http://assets.stickpng.com/images/580b57fcd9996e24bc43c4f8.png'
  //   },
  //   3: {
  //     'brand': 'New Balance',
  //     'logo':
  //         'https://logos-world.net/wp-content/uploads/2020/09/New-Balance-Logo-1972-2006.png'
  //   },
  // };
  //
  // int selectedIndex = 0;

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
                print(shoesCartList);
                print(shoesCartList.length);
              },
            ),
          ),
        ],
      ),
      body: Padding(
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
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: (itemWidth / itemHeight),
              children: nikeShoes.map((shoesSnap) {
                //final alreadyBuy = shoesCartList.contains(shoesSnap.data());

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
                        Text('¥ ${shoesSnap['price']}'),
                        IconButton(
                          icon: Icon(Icons.shopping_cart_outlined),
                          color: Colors.orange,
                          onPressed: () {
                            final snackBar = SnackBar(
                              content: Text(
                                '${shoesSnap['name']}をカートに追加しました！',
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            shoesCartList.add(shoesSnap.data());
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
    );
  }
}
