import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatefulWidget {
  List shoesCartList;
  PaymentScreen({Key? key, required this.shoesCartList}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int subTotalPrice = 0;
  double tax = 0.0;
  double totalPrice = 0;
  late String subTotalResult;
  late String taxResult;
  late String totalResult;

  @override
  void initState() {
    super.initState();

    for (var shoes in widget.shoesCartList) {
      subTotalPrice += shoes['price'] as int;
      tax = subTotalPrice * 0.1;
      totalPrice = subTotalPrice + tax;
    }
    final formatter = NumberFormat('#,###');
    subTotalResult = formatter.format(subTotalPrice);
    taxResult = formatter.format(tax);
    totalResult = formatter.format(totalPrice);
  }

  calculatePrice({shoes}) {
    subTotalPrice -= shoes['price'] as int;
    tax = subTotalPrice * 0.1;
    totalPrice = subTotalPrice + tax;
    final formatter = NumberFormat('#,###');
    subTotalResult = formatter.format(subTotalPrice);
    taxResult = formatter.format(tax);
    totalResult = formatter.format(totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(
        //   parent: AlwaysScrollableScrollPhysics(),
        // ),
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // physics: BouncingScrollPhysics(
                //   parent: AlwaysScrollableScrollPhysics(),
                // ),
                children: widget.shoesCartList.map((shoes) {
                  final formatter = NumberFormat('#,###');
                  var price = formatter.format(shoes['price']);

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // widget.shoesCartList.remove(shoes);
                        widget.shoesCartList
                            .removeWhere((removeShoes) => removeShoes == shoes);
                        setState(() {
                          widget.shoesCartList = widget.shoesCartList;
                        });
                        calculatePrice(shoes: shoes);
                      },
                      background: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(shoes['image']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      shoes['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      shoes['gender'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '¥$price',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 40),
            widget.shoesCartList.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.orange,
                        size: 150,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'カートにアイテムがありません',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('小計:'),
                              Text(
                                '¥$subTotalResult',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('税金:'),
                              Text(
                                '¥$taxResult',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '合計:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '¥$totalResult',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50),
                          Container(
                            height: 60,
                            child: ElevatedButton(
                              child: Center(
                                child: Text(
                                  '購入する',
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
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            Container(
              height: 100,
              color: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
