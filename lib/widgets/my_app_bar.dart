import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_light.dart';
import 'package:gap/gap.dart';

AppBar myAppBar(
    {required String title,
    String? stringColor,
    required bool implyLeading,
    required BuildContext context,
    bool? hasAction}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(fontSize: 18, color: Colors.black),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: implyLeading == true
        ? Transform.scale(
            scale: 0.7,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_backspace_rounded,
                size: 33,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ))
        : const SizedBox(),
    actions: hasAction == true
        ? [
            const Icon(
              IconlyBroken.Search,
              color: Colors.black,
            ),
            const Gap(15)
          ]
        : null,
  );
}
