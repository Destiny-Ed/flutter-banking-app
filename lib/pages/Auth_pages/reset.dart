import 'package:flutter/material.dart';
import 'package:flutter_banking_app/Constants/colors.dart';
import 'package:flutter_banking_app/Constants/widgets/buttons.dart';
import 'package:flutter_banking_app/Provider/authentication.dart';
import 'package:provider/provider.dart';

import 'new_password.dart';

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  //Color instance
  final MyColors _colors = MyColors();

  final TextEditingController _emailOrUsername = TextEditingController();

  ///Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height - 40,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: ListView(
                      primary: false,
                      shrinkWrap: true,
                      children: [
                        //Header text
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "Reset Password",
                                style: TextStyle(
                                  color: _colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Enter your username or email and we'll send you a link to get back into your account.",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //Email
                        TextFormField(
                          controller: _emailOrUsername,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email / username should be provided';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Email/Username',
                              border: OutlineInputBorder()),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        //Reset Button
                        Consumer<AuthenticationProvider>(
                            builder: (context, authProvider, child) {
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            //Show response message
                            if (authProvider.resMessage != '' &&
                                authProvider.resMessage != 'Please wait !' && !authProvider.resMessage.contains('`')) {
                              ///Show snackBar here
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(authProvider.resMessage)));

                              authProvider.clearMessage();
                            }
                          });
                          return GestureDetector(
                              onTap: authProvider.isLoading == true
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        ///Send user details and register
                                        authProvider.forgotPassword(
                                          emailOrUsername:
                                              _emailOrUsername.text.trim(),
                                          context: context,
                                        );
                                      }
                                    },
                              child: FormButton(
                                text: authProvider.isLoading == true
                                    ? Center(
                                      child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(color: _colors.white)))
                                    : Text("Submit",
                                        style: TextStyle(
                                            color: _colors.white,
                                            fontWeight: FontWeight.bold)),
                                color: _colors.primaryColor,
                              ));
                        }),

                        //Don't have an account
                        Container(
                          alignment: Alignment.center,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => NewPassword()));
                              },
                              child: Text("Have Code?",
                                  style:
                                      TextStyle(color: _colors.primaryColor))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showResponseMessage(
      AuthenticationProvider authProvider, BuildContext context) {
    Widget? widget;
    if (authProvider.resMessage != "") {
      if (authProvider.resMessage.contains("`") ||
          authProvider.resMessage == "Please wait !") {
        ///Request was successful
        widget = Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _colors.green,
            ),
            child: Text(
              authProvider.resMessage,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: _colors.white, fontWeight: FontWeight.bold),
            ));
      } else {
        widget = Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _colors.primaryColor,
            ),
            child: Text(
              authProvider.resMessage,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: _colors.white, fontWeight: FontWeight.bold),
            ));
      }
    } else {
      widget = Text("");
    }
    return widget;
  }
}
