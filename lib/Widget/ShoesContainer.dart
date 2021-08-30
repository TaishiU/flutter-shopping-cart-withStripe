import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/Model/Shoes.dart';

class ShoesContainer extends StatefulWidget {
  final List<DocumentSnapshot> listShoes;
  final BuildContext context;
  ShoesContainer({
    Key? key,
    required this.listShoes,
    required this.context,
  }) : super(key: key);

  @override
  _ShoesContainerState createState() => _ShoesContainerState();
}

class _ShoesContainerState extends State<ShoesContainer> {
  @override
  Widget build(BuildContext context) {
    // // アスペクト比を計算する
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 190) / 2;
    final double itemWidth = size.width / 2;

    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: (itemWidth / itemHeight),
      children: widget.listShoes.map((shoesSnap) {
        Shoes shoes = Shoes.fromDoc(shoesSnap);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                image: DecorationImage(
                  image: NetworkImage(shoes.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              shoes.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              shoes.gender,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('¥ ${shoes.price}'),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.orange,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}
