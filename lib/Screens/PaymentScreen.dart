import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final List shoesCartList;
  PaymentScreen({Key? key, required this.shoesCartList}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Text(
          widget.shoesCartList.length.toString(),
        ),
      ),
    );
  }
}
