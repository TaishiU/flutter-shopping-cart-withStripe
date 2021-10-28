// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:intl/intl.dart';
// import 'package:shopping_cart/PaymentService/PaymentService.dart';
// import 'package:shopping_cart/Screens/SuccessPayScreen.dart';
// import 'package:stripe_payment/stripe_payment.dart';
//
// class PaymentScreen extends StatefulWidget {
//   List shoesCartList;
//   PaymentScreen({
//     Key? key,
//     required this.shoesCartList,
//   }) : super(key: key);
//
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   int tax = 0;
//   int subTotalPrice = 0; /* Pay用 */
//   int totalPrice = 0; /* Pay用 */
//   late String subTotalResult; /* 表示用 */
//   late String totalResult; /* 表示用 */
//
//   @override
//   void initState() {
//     super.initState();
//
//     for (var shoes in widget.shoesCartList) {
//       subTotalPrice += shoes['price'] as int;
//       if (subTotalPrice < 15000) {
//         /*小計が15,000円未満であれば配送手数料550円がかかる*/
//         tax = 550;
//         totalPrice = subTotalPrice + tax;
//       } else {
//         /*小計が15,000円以上であれば配送手数料円がかかる*/
//         tax = 0;
//         totalPrice = subTotalPrice + tax;
//       }
//     }
//     final formatter = NumberFormat('#,###');
//     subTotalResult = formatter.format(subTotalPrice);
//     totalResult = formatter.format(totalPrice);
//
//     StripePayment.setOptions(
//       StripeOptions(publishableKey: dotenv.env['PUBLISHABLEKEY']),
//     );
//   }
//
//   calculatePrice({shoes}) {
//     subTotalPrice -= shoes['price'] as int;
//     if (subTotalPrice < 15000) {
//       /*小計が15,000円未満であれば配送手数料550円がかかる*/
//       tax = 550;
//       totalPrice = subTotalPrice + tax;
//     } else {
//       /*小計が15,000円以上であれば配送手数料は無料*/
//       tax = 0;
//       totalPrice = subTotalPrice + tax;
//     }
//     final formatter = NumberFormat('#,###');
//     subTotalResult = formatter.format(subTotalPrice);
//     totalResult = formatter.format(totalPrice);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: BackButton(
//           color: Colors.black,
//         ),
//         title: Text(
//           'カート',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               color: Colors.transparent,
//               child: ListView(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 children: widget.shoesCartList.map((shoes) {
//                   final formatter = NumberFormat('#,###');
//                   var price = formatter.format(shoes['price']);
//
//                   return Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     child: Dismissible(
//                       key: UniqueKey(),
//                       direction: DismissDirection.endToStart,
//                       onDismissed: (direction) {
//                         widget.shoesCartList
//                             .removeWhere((removeShoes) => removeShoes == shoes);
//                         setState(() {
//                           widget.shoesCartList = widget.shoesCartList;
//                         });
//                         calculatePrice(shoes: shoes);
//                       },
//                       background: Container(
//                         alignment: AlignmentDirectional.centerEnd,
//                         color: Colors.red,
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
//                           child: Icon(
//                             Icons.delete,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       child: Container(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   height: 80,
//                                   width: 80,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     image: DecorationImage(
//                                       image: NetworkImage(shoes['image']),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 20),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       shoes['name'],
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       shoes['gender'],
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Text(
//                                       '¥$price',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             IconButton(
//                               icon: Icon(
//                                 Icons.shopping_cart,
//                                 color: Colors.orange,
//                               ),
//                               onPressed: () {
//                                 widget.shoesCartList.removeWhere(
//                                     (removeShoes) => removeShoes == shoes);
//                                 setState(() {
//                                   widget.shoesCartList = widget.shoesCartList;
//                                 });
//                                 calculatePrice(shoes: shoes);
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//             widget.shoesCartList.length == 0
//                 ? Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.shopping_cart_outlined,
//                         color: Colors.orange,
//                         size: 150,
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         'アイテムがありません...',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   )
//                 : Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: Container(
//                       child: Column(
//                         children: [
//                           totalPrice < 15000
//                               ? Container(
//                                   padding: EdgeInsets.all(5),
//                                   decoration: BoxDecoration(
//                                     border: Border(
//                                       left: BorderSide(
//                                         color: Colors.grey.shade400,
//                                         width: 1,
//                                       ),
//                                       top: BorderSide(
//                                         color: Colors.grey.shade400,
//                                         width: 1,
//                                       ),
//                                       right: BorderSide(
//                                         color: Colors.grey.shade400,
//                                         width: 1,
//                                       ),
//                                       bottom: BorderSide(
//                                         color: Colors.grey.shade400,
//                                         width: 1,
//                                       ),
//                                     ),
//                                   ),
//                                   child: Text(
//                                       '*15,000円（税込）未満のご注文には、\n配送手数料550円がかかります。'),
//                                 )
//                               : SizedBox.shrink(),
//                           SizedBox(height: 40),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('小計:'),
//                               Text(
//                                 '¥$subTotalResult',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   //fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 15),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('配送手数料:'),
//                               Text(
//                                 '¥$tax',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   //fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 15),
//                           SizedBox(height: 15),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 '合計:',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 '¥$totalResult',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.orange,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 50),
//                           Container(
//                             height: 60,
//                             child: ElevatedButton(
//                               child: Center(
//                                 child: Text(
//                                   '購入する',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 primary: Colors.orange,
//                                 onPrimary: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                               ),
//                               onPressed: () async {
//                                 final bool isSuccess = await PaymentService()
//                                     .paymentForStripe(amountPrice: totalPrice);
//                                 if (isSuccess == true) {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => SuccessPayScreen(
//                                           totalResult: totalResult),
//                                     ),
//                                   );
//                                   print('決済成功！🔥');
//                                   print('決済金額は$totalResult円です');
//                                 } else {
//                                   print('決済失敗...');
//                                 }
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//             Container(
//               height: 100,
//               color: Colors.transparent,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
