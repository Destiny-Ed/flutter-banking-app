// import 'package:fade_shimmer/fade_shimmer.dart';
// import 'package:flutter/material.dart';

// class Loaders {






//   ///Thread shimmer loader
// Widget shimmerForThreads(BuildContext context, int index) {
//   bool isDarkMode = false;
//   final delay = (index * 300);
//   return Container(
//     decoration: BoxDecoration(
//         color: isDarkMode == true ? Color(0xff242424) : Colors.white,
//         borderRadius: BorderRadius.circular(8)),
//     margin: EdgeInsets.symmetric(horizontal: 16),
//     padding: EdgeInsets.symmetric(vertical: 16),
//     child: Column(
//       children: [
//         Row(
//           children: [
//             FadeShimmer.round(
//               size: 40,
//               fadeTheme: isDarkMode == true ? FadeTheme.dark : FadeTheme.light,
//               millisecondsDelay: delay,
//             ),
//             SizedBox(
//               width: 8,
//             ),
//             Expanded(
//               child: Column(
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   FadeShimmer(
//                     height: 8,
//                     width: MediaQuery.of(context).size.width,
//                     radius: 4,
//                     millisecondsDelay: delay,
//                     fadeTheme:
//                         isDarkMode == true ? FadeTheme.dark : FadeTheme.light,
//                   ),
//                   SizedBox(
//                     height: 6,
//                   ),
//                   FadeShimmer(
//                     height: 8,
//                     millisecondsDelay: delay,
//                     width: MediaQuery.of(context).size.width,
//                     radius: 4,
//                     fadeTheme:
//                         isDarkMode == true ? FadeTheme.dark : FadeTheme.light,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         FadeShimmer(
//           height: 80,
//           millisecondsDelay: delay,
//           width: MediaQuery.of(context).size.width,
//           radius: 4,
//           fadeTheme: isDarkMode == true ? FadeTheme.dark : FadeTheme.light,
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         FadeShimmer(
//           height: 20,
//           millisecondsDelay: delay,
//           width: MediaQuery.of(context).size.width,
//           radius: 4,
//           fadeTheme: isDarkMode == true ? FadeTheme.dark : FadeTheme.light,
//         ),
//       ],
//     ),
//   );
// }

// }