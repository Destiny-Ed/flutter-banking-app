import 'package:flutter/material.dart';

class PageNavigator {
  PageNavigator({required this.context});

  final BuildContext context;

  ///Next page and remove back stack
  void nextPageAndUntil({Widget? page}) {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => page!), (route) => false);
  }

  ///Next page and keep back stack
  void nextPage({Widget? page}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page!));
  }
}
