import 'package:flutter/material.dart';
import 'package:flutter_banking_app/Constants/colors.dart';
import 'package:flutter_banking_app/Constants/widgets/buttons.dart';
import 'package:flutter_banking_app/Constants/widgets/form_field.dart';
import 'package:flutter_banking_app/Provider/authentication.dart';
import 'package:flutter_banking_app/Provider/storage_provider.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  //color Instance
  final MyColors _colors = MyColors();

  ///Text Feild controllers
  final TextEditingController _code = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmEmail = TextEditingController();

  ///Form Key
  final GlobalKey<FormState> _formKey = GlobalKey();

  String? email;

  @override
  void initState() {
    super.initState();

    Database().getEmail().then((value) {
      setState(() {
        email = value;
      });
      print(email);
    });
  }

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
                        //Header Text
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "New Password",
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
                                "Enter the code you received and a new password",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //Code
                        TextFormField(
                          controller: _code,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Fill in the required field';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Code', border: OutlineInputBorder()),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        //New Password
                        CustomTextField(
                          _newPassword,
                          hint: "New Password",
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        //Confirm password
                        CustomTextField(
                          _confirmEmail,
                          newPassword: _newPassword.text,
                          hint: "Confirm Password",
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        //Submit Button
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
                                      if (_formKey.currentState!.validate()) {
                                        ///Send user details
                                        authProvider.newPassword(
                                          email: email!,
                                          code: _code.text.trim(),
                                          password: _newPassword.text.trim(),
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
                                            child: CircularProgressIndicator(
                                                color: _colors.white)))
                                    : Text("Submit",
                                        style: TextStyle(
                                            color: _colors.white,
                                            fontWeight: FontWeight.bold)),
                                color: _colors.primaryColor,
                              ));
                        }),

                        //Login with new account account
                        Container(
                          alignment: Alignment.center,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => Login()));
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(color: _colors.primaryColor),
                              )),
                        )
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
      if (authProvider.resMessage == "Password was successfully changed !" ||
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
