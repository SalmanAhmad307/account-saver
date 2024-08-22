// // import 'package:account_saver/routes/routes.dart';
// // import 'package:flutter/material.dart';

// // class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
// //   const CustomAppBar({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return AppBar(
// //       backgroundColor: Colors.blueGrey.shade800,
// //       elevation: 6.0,
// //       title: RichText(
// //         text: const TextSpan(
// //           children: [
// //             TextSpan(
// //               text: 'Accounter',
// //               style: TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 26.0,
// //                 color: Colors.cyanAccent,
// //                 shadows: [
// //                   Shadow(
// //                     blurRadius: 4.0,
// //                     color: Colors.black45,
// //                     offset: Offset(2.0, 2.0),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             TextSpan(
// //               text: ' ++',
// //               style: TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 26.0,
// //                 color: Colors.amberAccent,
// //                 shadows: [
// //                   Shadow(
// //                     blurRadius: 4.0,
// //                     color: Colors.black45,
// //                     offset: Offset(2.0, 2.0),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       actions: [
// //         IconButton(
// //           icon: const Icon(Icons.star, color: Colors.yellowAccent),
// //           onPressed: () {
// //             Navigator.pushNamed(context, Routes.favorites);
// //           },
// //         ),
// //         IconButton(
// //           icon: const Icon(Icons.more_vert, color: Colors.white),
// //           onPressed: () {
// //             // Handle the three dots button press
// //           },
// //         ),
// //       ],
// //     );
// //   }

// //   @override
// //   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// // }
// import 'package:account_saver/routes/routes.dart';
// import 'package:flutter/material.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.blueGrey.shade800,
//       elevation: 6.0,
//       title: RichText(
//         text: const TextSpan(
//           children: [
//             TextSpan(
//               text: 'Accounter',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 26.0,
//                 color: Colors.cyanAccent,
//                 shadows: [
//                   Shadow(
//                     blurRadius: 4.0,
//                     color: Colors.black45,
//                     offset: Offset(2.0, 2.0),
//                   ),
//                 ],
//               ),
//             ),
//             TextSpan(
//               text: ' ++',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 26.0,
//                 color: Colors.amberAccent,
//                 shadows: [
//                   Shadow(
//                     blurRadius: 4.0,
//                     color: Colors.black45,
//                     offset: Offset(2.0, 2.0),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.star, color: Colors.yellowAccent),
//           onPressed: () {
//             Navigator.pushNamed(context, Routes.favorites);
//           },
//         ),
//         PopupMenuButton<int>(
//           icon: const Icon(Icons.more_vert, color: Colors.white),
//           onSelected: (value) {
//             // Handle the selected value
//             switch (value) {
//               case 1:
//                 // Handle option 1
//                 break;
//               case 2:
//                 // Handle option 2
//                 break;
//               case 3:
//                 // Handle option 3
//                 break;
//             }
//           },
//           itemBuilder: (BuildContext context) {
//             return <PopupMenuEntry<int>>[
//               const PopupMenuItem<int>(
//                 value: 1,
//                 child: Text('Option 1'),
//               ),
//               const PopupMenuItem<int>(
//                 value: 2,
//                 child: Text('Option 2'),
//               ),
//               const PopupMenuItem<int>(
//                 value: 3,
//                 child: Text('Option 3'),
//               ),
//             ];
//           },
//         ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

import 'package:account_saver/routes/routes.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Hey, User',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26.0,
                color: Colors.black54,
                shadows: [
                  Shadow(
                    blurRadius: 4.0,
                    color: Colors.black45,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, Routes.search);
          },
        ),
        IconButton(
          icon: const Icon(Icons.star, color: Color.fromARGB(255, 182, 155, 2)),
          onPressed: () {
            Navigator.pushNamed(context, '/favorites');
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications,
              color: Color.fromARGB(255, 199, 160, 3)),
          onPressed: () {
            Navigator.pushNamed(context, '/favorites');
          },
        ),
        // PopupMenuButton<int>(
        //   icon: const Icon(Icons.more_vert, color: Colors.white),
        //   onSelected: (value) {
        //     // Handle the selected value
        //     switch (value) {
        //       case 1:
        //         // Handle option 1
        //         break;
        //       case 2:
        //         // Handle option 2
        //         break;
        //       case 3:
        //         // Handle option 3
        //         break;
        //     }
        //   },
        //   itemBuilder: (BuildContext context) {
        //     return <PopupMenuEntry<int>>[
        //       const PopupMenuItem<int>(
        //         value: 1,
        //         child: Text('Option 1'),
        //       ),
        //       const PopupMenuItem<int>(
        //         value: 2,
        //         child: Text('Option 2'),
        //       ),
        //       const PopupMenuItem<int>(
        //         value: 3,
        //         child: Text('Option 3'),
        //       ),
        //     ];
        //   },
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
