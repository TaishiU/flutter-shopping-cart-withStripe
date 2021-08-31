import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShoesContainer extends StatefulWidget {
  final List<DocumentSnapshot> listShoes;
  ShoesContainer({
    Key? key,
    required this.listShoes,
  }) : super(key: key);

  @override
  _ShoesContainerState createState() => _ShoesContainerState();
}

class _ShoesContainerState extends State<ShoesContainer> {
  final List shoesCartList = []; /*カートに入れた商品リスト*/

  @override
  Widget build(BuildContext context) {
    // // アスペクト比を計算する
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 300) / 2;
    final double itemWidth = size.width / 2;

    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: (itemWidth / itemHeight),
      children: widget.listShoes.map((shoesSnap) {
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
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    shoesCartList.add(shoesSnap.data());
                    print(shoesCartList);
                    print(shoesCartList.length);
                  },
                ),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}
