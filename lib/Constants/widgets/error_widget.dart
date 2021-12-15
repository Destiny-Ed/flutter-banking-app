import 'package:flutter/material.dart';
import 'package:flutter_banking_app/Constants/colors.dart';

errorWidget({BuildContext? context, String? message, VoidCallback? onRetry}) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    ///Icon

    Text(
      message!,
      textAlign: TextAlign.center,
    ),

    GestureDetector(
      onTap: onRetry,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context!).size.width - 200,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 20),
        child: Text(
          "Retry",
          style: TextStyle(
            color: MyColors().primaryColor,
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: MyColors().primaryColor)),
      ),
    )
  ]);
}