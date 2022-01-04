import 'package:flutter/material.dart';
import 'package:flutter_banking_app/Constants/colors.dart';

showErrorSnackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
      content: Text(
        message,
        style: TextStyle(color: MyColors().black),
      ),
      backgroundColor: MyColors().white,
    ),
  );
}

showSuccessSnackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    padding: const EdgeInsets.all(10),
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(color: MyColors().white),
    ),
    backgroundColor: MyColors().primaryColor,
  ));
}
