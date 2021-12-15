import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/Constants/route.dart';
import 'package:flutter_banking_app/Provider/storage_provider.dart';
import 'package:flutter_banking_app/generated/assets.dart';
import 'package:flutter_banking_app/json/shortcut_list.dart';
import 'package:flutter_banking_app/pages/Auth_pages/login.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_bold.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/my_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Styles.primaryColor,
      appBar: myAppBar(title: 'Profile ', implyLeading: true, context: context),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const Gap(40),
          Consumer<Database>(
            builder: (context, db, child) {
              db.getName();
              db.getProfileImage();
              return Stack(
                children: [
                  Container(
                    height: 280,
                    alignment: Alignment.bottomCenter,
                    // color: Styles.primaryColor,
                    child: Container(
                      height: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // color: Styles.primaryWithOpacityColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Gap(60),
                          Center(
                              child: Text(db.name,
                                  style: const TextStyle(fontSize: 25))),
                          const Gap(10),
                          // const Text(
                          //   'Male',
                          // ),
                          const Gap(25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: profilesShortcutList.map<Widget>((e) {
                              return GestureDetector(
                                onTap: () {
                                  switch (e['title']) {
                                    case 'Logout':
                                      Database().logOut().then((value) {
                                        PageNavigator(context: context)
                                            .nextPageAndUntil(page: Login());
                                      });
                                      break;
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      padding: const EdgeInsets.all(13),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Icon(e['icon'], color: e['color']),
                                    ),
                                    Text(e['title'])
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          const Gap(25)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30,
                    right: 30,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      // child: Transform.scale(
                      //   scale: 0.55,
                      //   child: Image.asset(Assets.memoji1),
                      // ),
                      child: Transform.scale(
                        scale: 0.55,
                        child: Image.network(db.userProfileImage),
                      ),
                    ),
                  )
                ],
              );
            }
          ),
          const Gap(35),
          customListTile(
              icon: IconlyBold.Profile,
              color: const Color(0xFFC76CD9),
              title: 'Information'),
          customListTile(
              icon: IconlyBold.Shield_Done,
              color: const Color(0xFF229e76),
              title: 'Security'),
          customListTile(
              icon: IconlyBold.Message,
              color: const Color(0xFFe17a0a),
              title: 'Contact us'),
          customListTile(
              icon: IconlyBold.Document,
              color: const Color(0xFF064c6d),
              title: 'Support'),
          // customListTile(
          //     icon: Icons.dark_mode,
          //     color: const Color(0xFF0536e8),
          //     title: 'Dark Mode',
          //     isDarkMode: true),
        ],
      ),
    );
  }

  Widget customListTile(
      {required IconData icon,
      required String title,
      VoidCallback? callback,
      required Color color,
      bool? isDarkMode}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2),
      leading: Container(
        width: 42,
        height: 42,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Styles.primaryWithOpacityColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      minLeadingWidth: 50,
      horizontalTitleGap: 13,
      title: Text(title, style: const TextStyle(fontSize: 17)),
      trailing: isDarkMode == true
          ? CupertinoSwitch(
              thumbColor: Colors.red,
              activeColor: Styles.primaryColor,
              trackColor: Styles.primaryColor,
              value: true,
              onChanged: (v) {},
            )
          : Icon(CupertinoIcons.arrow_right,
              color: Colors.white.withOpacity(0.7)),
      onTap: callback,
    );
  }
}
