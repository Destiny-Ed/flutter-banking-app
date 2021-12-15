import 'package:flutter/material.dart';
import 'package:flutter_banking_app/Constants/colors.dart';

///Custom Form Field
class CustomTextField extends StatefulWidget {
  final TextEditingController _controller;
  bool obscure;
  String hint;
  bool password;
  int maxLines;
  bool readOnly;
  VoidCallback? onTap;
  int minLines;
  String? newPassword;
  Function(String)? validate;
  CustomTextField(
    this._controller, {
    this.password = true,
    this.obscure = true,
    this.hint = '',
    this.readOnly = false,
    this.validate,
    this.onTap,
    this.newPassword,
    this.maxLines = 1,
    this.minLines = 1,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  //Color Instance
  final MyColors _colors = MyColors();
  Icon? visibility;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Fill in your password';
        } else if (widget.newPassword != null && widget.newPassword != value) {
          return 'Password do not match';
        }
      },
      obscureText: widget.obscure,
      maxLines: widget.maxLines,
      onTap: widget.onTap,
      minLines: widget.minLines,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        labelText: widget.hint,
        border: OutlineInputBorder(),
        suffixIcon: widget.password == true
            ? GestureDetector(
                key: widget.key,
                onTap: () {
                  //Show and hide password
                  if (widget.obscure == true) {
                    setState(() {
                      widget.obscure = false;
                      visibility = Icon(
                        Icons.visibility,
                        color: _colors.primaryColor,
                      );
                    });
                  } else {
                    setState(() {
                      widget.obscure = true;
                      visibility = Icon(
                        Icons.visibility_off,
                        color: _colors.primaryColor,
                      );
                    });
                  }
                },
                child: visibility == null
                    ? Icon(
                        Icons.visibility_off,
                        color: _colors.primaryColor,
                      )
                    : visibility,
              )
            : const Text(""),
      ),
    );
    // return Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(5),
    //     border: Border.all(color: _colors.grey),
    //   ),
    //   padding: const EdgeInsets.symmetric(horizontal: 10),
    //   child: TextFormField(
    //     key: widget.key,
    //     controller: widget._controller,
    // obscureText: widget.obscure,
    // maxLines: widget.maxLines,
    //     validator: (value) => widget.validate!(value!),
    //     minLines: widget.minLines,
    //     decoration: InputDecoration(
    //       border: InputBorder.none,
    // suffixIcon: widget.password == true
    //     ? GestureDetector(
    //         key: widget.key,
    //         onTap: () {
    //           //Show and hide password
    //           if (widget.obscure == true) {
    //             setState(() {
    //               widget.obscure = false;
    //               visibility = Icon(
    //                 Icons.visibility_off,
    //                 color: _colors.primaryColor,
    //               );
    //             });
    //           } else {
    //             setState(() {
    //               widget.obscure = true;
    //               visibility = Icon(
    //                 Icons.visibility,
    //                 color: _colors.primaryColor,
    //               );
    //             });
    //           }
    //         },
    //         child: visibility == null
    //             ? Icon(
    //                 Icons.visibility,
    //                 color: _colors.primaryColor,
    //               )
    //             : visibility,
    //       )
    //     : const Text(""),
    //       contentPadding: const EdgeInsets.only(
    //         top: 15,
    //         bottom: 10,
    //       ),
    //       hintText: widget.hint,
    //     ),
    //   ),
    // );
  }
}
