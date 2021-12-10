import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/Constants/colors.dart';
import 'package:flutter_banking_app/Constants/route.dart';
import 'package:flutter_banking_app/Constants/widgets/buttons.dart';
import 'package:flutter_banking_app/Constants/widgets/form_field.dart';
import 'package:flutter_banking_app/Provider/authentication.dart';
import 'package:flutter_banking_app/pages/Auth_pages/register.dart';
import 'package:flutter_banking_app/pages/Auth_pages/reset.dart';
import 'package:flutter_banking_app/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  //Instantiate color class
  final MyColors _colors = MyColors();

  ///Text Feild controllers
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  ///Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // AuthenticationProvider authProvider =
    //     Provider.of<AuthenticationProvider>(context);
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
                        ///Logo and text
                        Container(
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/logo.png",
                                width: MediaQuery.of(context).size.width - 150,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Welcome to Convre, Africa's best. Your communities are waiting for you",
                                textAlign: TextAlign.center,
                                // style: TextStyle(color: _colors.grey),
                              ),

                              const SizedBox(
                                height: 35,
                              ),
                              

        
                            ],
                          ),
                        ),

                        TextFormField(
                          controller: _email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email should be provided';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder()),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        // Password
                        CustomTextField(
                          _password,
                          hint: "Password",
                        ),

                        //Forgot password?
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => Reset()));
                              },
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),

                        //Login Button

                        Consumer<AuthenticationProvider>(
                            builder: (context, authProvider, child) {
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            //Show response message
                            if (authProvider.resMessage != '' &&
                                authProvider.resMessage != 'Please wait !') {
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
                                    authProvider.clearMessage();
                                    if (_formKey.currentState!.validate()) {
                                      authProvider.loginUser(
                                        email: _email.text.trim(),
                                        password: _password.text.trim(),
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
                                          child: CircularProgressIndicator(color: _colors.white,)))
                                  : Text("Login",
                                      style: TextStyle(
                                          color: _colors.white,
                                          fontWeight: FontWeight.bold)),
                              color: _colors.primaryColor,
                            ),
                          );
                        }),

                        //Don't have an account
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? "),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Register()));
                                  },
                                  child: Text("Register",
                                      style: TextStyle(
                                          color: _colors.primaryColor))),
                            ],
                          ),
                        ),

                        //About
                        // GestureDetector(
                        //   onTap: () {
                        //     PageNavigator(context: context)
                        //         .nextPage(page: TermAndConditionsPage());
                        //   },
                        //   child: Container(
                        //     margin: const EdgeInsets.only(bottom: 40),
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       "About | Terms of Use",
                        //       style: TextStyle(color: _colors.grey),
                        //     ),
                        //   ),
                        // ),
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

  // Widget showResponseMessage(
  //     AuthenticationProvider authProvider, BuildContext context) {
  //   Widget? widget;
  //   if (authProvider.resMessage != "") {
  //     if (authProvider.resMessage == "Login was successful!") {
  //       ///Authentication was successful
  //       ///Navigate user to Home page
  //       widget = Text("");

  //       WidgetsBinding.instance!.addPostFrameCallback((_) {
  //         PageNavigator(context: context)
  //             .nextPageAndUntil(page: const BottomNav());
  //       });
  //     } else if (authProvider.resMessage == "Please wait !") {
  //       widget = Container(
  //           alignment: Alignment.center,
  //           padding: const EdgeInsets.all(10),
  //           margin: const EdgeInsets.only(bottom: 5),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             color: _colors.green,
  //           ),
  //           child: Text(
  //             authProvider.resMessage,
  //             textAlign: TextAlign.center,
  //             style:
  //                 TextStyle(color: _colors.white, fontWeight: FontWeight.bold),
  //           ));
  //     } else {
  //       widget = Container(
  //           alignment: Alignment.center,
  //           padding: const EdgeInsets.all(10),
  //           margin: const EdgeInsets.only(bottom: 5),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             color: _colors.primaryColor,
  //           ),
  //           child: Text(
  //             authProvider.resMessage,
  //             textAlign: TextAlign.center,
  //             style:
  //                 TextStyle(color: _colors.white, fontWeight: FontWeight.bold),
  //           ));
  //     }
  //   } else {
  //     widget = const Text('');
  //   }
  //   return widget;
  // }
}
