import 'package:flutter/material.dart';
import 'package:flutter_banking_app/Provider/authentication.dart';
import 'package:flutter_banking_app/Provider/storage_provider.dart';
import 'package:flutter_banking_app/pages/Auth_pages/login.dart';
import 'package:flutter_banking_app/pages/splash.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ///Authentication provider
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => Database()),
      ],
      child: MaterialApp(
        title: 'Shopay App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'DMSans',
          // primaryColor: Styles.primaryColor,
          // backgroundColor: Styles.primaryColor,
        ),
        home: const Splash(),
      ),
    );
  }
}
