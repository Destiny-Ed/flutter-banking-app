import 'package:flutter/material.dart';
import 'package:flutter_banking_app/Constants/colors.dart';
import 'package:flutter_banking_app/Constants/route.dart';
import 'package:flutter_banking_app/Constants/utils.dart';
import 'package:flutter_banking_app/Constants/widgets/buttons.dart';
import 'package:flutter_banking_app/Constants/widgets/form_field.dart';
import 'package:flutter_banking_app/Provider/authentication.dart';
import 'package:provider/provider.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isChecked = false;

  //Color Instance
  final MyColors _colors = MyColors();

  ///Text Feild controllers
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

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
                      shrinkWrap: true,
                      primary: true,
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
                                "Welcome to Shopay",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: _colors.grey),
                              ),

                              const SizedBox(
                                height: 35,
                              ),
                              //Social buttons
                            
                            ],
                          ),
                        ),

                        //Email
                        TextFormField(
                          controller: _email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email should be provided';
                            } else if (validateEmail(_email.text.trim()) ==
                                false) {
                              return "Provide a valid email address";
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Email', border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        //Username
                        TextFormField(
                          controller: _username,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Fill in your username';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        //Password
                        CustomTextField(
                          _password,
                          hint: "Password",
                        ),

                        //Agreement?
                        CheckboxListTile(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 0.0),
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            "I agree to the Terms of Use and Privacy Policy",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),

                        //Register Button
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
                                    if (_isChecked == false) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Please read and agree to out terms of use')));
                                    } else if (_formKey.currentState!
                                        .validate()) {
                                      if (mounted) {
                                        authProvider.registerUser(
                                          email: _email.text.trim(),
                                          password: _password.text.trim(),
                                          username: _username.text.trim(),
                                          context: context,
                                        );
                                      }
                                    }
                                  },
                            child: FormButton(
                              text: authProvider.isLoading == true
                                  ? Center(
                                      child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(color: _colors.white)))
                                  : Text("Register",
                                      style: TextStyle(
                                          color: _colors.white,
                                          fontWeight: FontWeight.bold)),
                              color: _colors.primaryColor,
                            ),
                          );
                        }),

                        //Already have an account
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account? "),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Login()));
                                  },
                                  child: Text("Login",
                                      style: TextStyle(
                                          color: _colors.primaryColor))),
                            ],
                          ),
                        ),

                        // //About
                        // GestureDetector(
                        //   onTap: () {
                        //     PageNavigator(context: context)
                        //         .nextPage(page: TermAndConditionsPage());
                        //   },
                        //   child: Container(
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
  //     if (authProvider.resMessage == "Account created!") {
  //       ///Authentication was successful
  //       ///Navigate user to Home page
  //       widget = Text("");

  //       WidgetsBinding.instance!.addPostFrameCallback((_) {
  //         PageNavigator(context: context)
  //             .nextPageAndUntil(page: MainActivity());
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
  //             color: _colors.red,
  //           ),
  //           child: Text(
  //             authProvider.resMessage,
  //             textAlign: TextAlign.center,
  //             style:
  //                 TextStyle(color: _colors.white, fontWeight: FontWeight.bold),
  //           ));
  //     }
  //   } else {
  //     widget = Text("");
  //   }
  //   return widget;
  // }
}
