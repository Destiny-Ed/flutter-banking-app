import 'package:flutter/material.dart';
import 'package:flutter_banking_app/Constants/route.dart';
import 'package:flutter_banking_app/Provider/storage_provider.dart';
import 'package:flutter_banking_app/pages/Auth_pages/login.dart';
import 'package:flutter_banking_app/widgets/bottom_nav.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Database().getToken().then((value) {
        if (value == '') {
          PageNavigator(context: context).nextPageAndUntil(page: Login());
        } else {
          PageNavigator(context: context)
              .nextPageAndUntil(page: const BottomNav());
        }
      });
    });
    return const Scaffold(
      body: Center(
        child: Text('Shopay'),
      ),
    );
  }
}
