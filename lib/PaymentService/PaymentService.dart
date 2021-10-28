// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:stripe_payment/stripe_payment.dart';
//
// class PaymentService {
//   Future<bool> paymentForStripe({required int amountPrice}) async {
//     try {
//       //paymentMethod
//       PaymentMethod paymentMethod =
//           await StripePayment.paymentRequestWithCardForm(
//         CardFormPaymentRequest(),
//       );
//
//       //paymentIntent
//       final String createPaymentIntentUrl =
//           'https://asia-northeast1-shopping-cart-21109.cloudfunctions.net/create_payment_intent';
//       final int amount = amountPrice;
//       final String currency = 'JPY';
//       final finalUrl =
//           '$createPaymentIntentUrl?amount=$amount&currency=$currency';
//       final http.Response response = await http.post(Uri.parse(finalUrl));
//       final responseData = jsonDecode(response.body);
//       final String paymentIntentClientSecret = responseData['clientSecret'];
//
//       //paymentIntent
//       StripePayment.confirmPaymentIntent(
//         PaymentIntent(
//           clientSecret: paymentIntentClientSecret,
//           paymentMethodId: paymentMethod.id,
//         ),
//       );
//       return true;
//     } catch (e) {
//       print('エラー: $e');
//       return false;
//     }
//   }
// }
