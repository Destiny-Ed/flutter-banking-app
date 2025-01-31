import 'package:flutter/material.dart';
import 'package:flutter_banking_app/pages/Bottom_nav_pages/send_money.dart';
import 'package:flutter_banking_app/pages/Payment/enter_amount_page.dart';
import 'package:flutter_banking_app/utils/iconly/iconly_bold.dart';

List shortcutList = [
  {
    'color': const Color(0xFF026EF4),
    'icon': IconlyBold.Download,
    'title' : 'Top Up',
    'route' : const WalletPage(),
  },
  {
    'color': const Color(0xFFFB6A4B),
    'icon': IconlyBold.Upload,
    'route': const SendMoney(),
    'title' : 'Send'
  },
  // {
  //   'color': const Color(0xFF2BB33A),
  //   'icon': IconlyBold.VirtualCardPage,
  //   'title' : 'Bills'
  // },
  // {
  //   'color': const Color(0xFFAF52C1),
  //   'icon': IconlyBold.Category,
  //   'title' : 'Airtime'
  // },
];

List profilesShortcutList = [
  // {
  //   'color': const Color(0xFFe2a935),
  //   'icon': IconlyBold.Chart,
  // },
  // {
  //   'color': const Color(0xFF2290b8),
  //   'icon': IconlyBold.Notification,
  //   'title' : 'Notification'
  // },
  {
    'color': const Color(0xFF6bcde8),
    'icon': IconlyBold.Setting,
    'title' : 'Setting'
  },
  {
    'color': const Color(0xFF6b41dc),
    'icon': Icons.logout,
    'title' : 'Logout'
  },
];
