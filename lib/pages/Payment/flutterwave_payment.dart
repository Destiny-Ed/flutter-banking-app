import 'package:flutter/material.dart';
import 'package:flutter_banking_app/Constants/url.dart';
import 'package:flutter_banking_app/pages/Payment/callback_url.dart';
import 'package:flutter_banking_app/pages/Payment/payment_ref.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';

///FlutterWavePayment payment class
class FlutterWavePayment {
  ///Constructor
  FlutterWavePayment(
      {this.amount, this.ctx, this.email, this.phone, this.name});

  ///Context
  BuildContext? ctx;

  /// Customer Email
  String? email;

  /// Customer Amount To Pay
  String? amount;

  String? phone;

  String? name;

  ///flutter wave payment
  void makePayment() async {
    final refId = getPaymentRef();
    try {
      Flutterwave flutterwave = Flutterwave.forUIPayment(
        context: ctx!,
        encryptionKey: 'FLWSECK_TEST4734027149f5',
        publicKey: 'FLWPUBK_TEST-e8d4cd5462fb381c4163ba7f7f746a98-X',
        currency: 'NGN',
        amount: amount!,
        email: email!,
        fullName: name!,
        txRef: refId,
        isDebugMode: true,
        phoneNumber: phone!,
        acceptCardPayment: true,
      );

      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();

      // ignore: unnecessary_null_comparison
      if (response == null) {
        ScaffoldMessenger.of(ctx!).showSnackBar(SnackBar(
          content: Text('Transaction Failed'),
        ));
      } else {
        ///
        if (response.status == "success") {
          print(
              '::::::::::::::::::::::::::::::::::::::::::Payment successfully');

          ///Send Transaction Id to Database for payment verification
          sendTransactionRef(transactionRef: refId);
        } else {
          ScaffoldMessenger.of(ctx!).showSnackBar(const SnackBar(
            content: Text('Transaction Failed'),
          ));
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(ctx!).showSnackBar(SnackBar(
        content: Text('Transaction Failed ${error.toString()}'),
      ));
    }
  }
}
