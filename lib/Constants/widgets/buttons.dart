import 'package:flutter/material.dart';
import 'package:flutter_banking_app/Constants/colors.dart';
// import 'package:mobile/theme/theme.dart';

class FormButton extends StatelessWidget {
  FormButton({required this.text, this.color});

  final Widget text;
  final Color? color;

  //Color Instance
  // MyColors _colors = MyColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(18),
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: text,
    );
  }
}

///
class SocialButton extends StatelessWidget {
  SocialButton({required this.text, required this.icon});

  final String text;
  final Widget icon;

  //Color Instance
  final MyColors _colors = MyColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: _colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(text,
              style:
                  TextStyle(color: _colors.black, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
