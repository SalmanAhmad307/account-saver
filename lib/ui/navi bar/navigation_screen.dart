import 'package:account_saver/core/constants/app_colors.dart';
import 'package:account_saver/core/constants/media_query.dart';

import 'package:account_saver/ui/navi%20bar/home/home_screen.dart';
import 'package:account_saver/ui/navi%20bar/blog/main_news_screen.dart';
import 'package:account_saver/ui/navi%20bar/setting_screen/setting_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    //const BlogScreen(),
    const MainNewsScreen(),
    const SettingScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Adjust the view when keyboard is visible

      // appBar: const CustomAppBar(),
      backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white,
      //   onPressed: () {
      //     showModalBottomSheet(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return const AddBankAccount();
      //       },
      //     );
      //   },
      //   child: Icon(
      //     Icons.add,
      //     size: MySize.size30,
      //     color: Colors.blueGrey,
      //   ),
      // ),
      body: _screens[_currentIndex],

      // IndexedStack(
      //   index: _currentIndex,
      //   children: _screens,
      // ),
      bottomNavigationBar: NavigationBar(
        //backgroundColor: AppColors.borderColorDark,
        shadowColor: Colors.white,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index)=>_onTabTapped(index),
        destinations: const [
          NavigationDestination(
              icon:Icon( Icons.home,),
              label: 'Home',
          ),
          NavigationDestination(
            icon:Icon( Icons.insert_drive_file_outlined,),
            label: 'Blogs',
          ),

          NavigationDestination(
            icon:Icon( Icons.settings,),
            label: 'Settings',
          ),
        ],

      ),

      // Container(
      //   width: double.infinity,
      //   //height: MySize.size150,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(10),
      //       topRight: Radius.circular(10),
      //       bottomLeft: Radius.circular(10),
      //       bottomRight: Radius.circular(10),
      //     ),
      //     color:AppColors.borderColorDark,
      //   ),
      //   child: BottomNavigationBar(
      //     currentIndex: _currentIndex,
      //     selectedItemColor: Colors.white,
      //     unselectedItemColor: Colors.white30,
      //     backgroundColor: AppColors.borderColorDark,
      //     onTap: _onTabTapped,
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: 'Home',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.insert_drive_file_outlined),
      //         label: 'Blogs',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.settings),
      //         label: 'Settings',
      //       ),
      //     ],
      //   ),
      // ),


    );
  }
}


// import 'package:account_saver/core/constants/app_colors.dart';
// import 'package:account_saver/ui/home/navigation_screen.dart';
// import 'package:account_saver/ui/navi%20bar/blog/main_news_screen.dart';
// import 'package:account_saver/ui/navi%20bar/setting_screen/setting_screen.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _screens = [
//     const HomeScreen2(),
//     const MainNewsScreen(),
//     const SettingScreen(),
//   ];
//
//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Stack(
//         children: [
//           IndexedStack(
//             index: _currentIndex,
//             children: _screens,
//           ),
//           Positioned(
//             left: 20,
//             right: 20,
//             //top: 10,
//             bottom:
//                 10, // Adjust this value to control how high the app bar floats
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(
//                   22.0), // Rounded corners for floating effect
//               child: ConvexAppBar(
//                 backgroundColor: AppColors.borderColorDark,
//                 height: 50, // Height of the floating app bar
//                 style: TabStyle.reactCircle, // Animation style
//                 elevation: 8, // Elevation for a shadow effect
//                 curveSize: 50, // Decreased curve size for smaller highlight
//                 top: -4, // Adjust top to fine-tune the highlight position
//                 items: const [
//                   TabItem(icon: Icons.home, title: 'Home'),
//                   TabItem(
//                       icon: Icons.insert_drive_file_outlined, title: 'Blogs'),
//                   TabItem(icon: Icons.settings, title: 'Settings'),
//                 ],
//                 initialActiveIndex: _currentIndex,
//                 onTap: _onTabTapped,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SettingsScreen extends StatefulWidget {
//
//   const SettingsScreen({super.key});
//
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   bool isThemeDark=false;
//   @override
//   Widget build(BuildContext context) {
//     MySize().init(context);
//
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       appBar: const CustomAppBar(title: "Settings"),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           //mainAxisAlignment: MainAxisAlignment.center,
//           //crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: MySize.size20,
//             ),
//             Container(
//               padding: EdgeInsets.only(
//                 left: 15,
//                 right: 10,
//               ),
//               width: double.infinity,
//               //sheight: MySize.size200,
//               decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5), // color of shadow
//                       spreadRadius: 5, // spread radius of the shadow
//                       blurRadius: 7, // blur radius of the shadow
//                       offset: Offset(0, 3), // changes position of shadow
//                     ),
//                   ],
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10),
//                     bottomRight: Radius.circular(10),
//                     bottomLeft: Radius.circular(10),
//                   ),
//                   color: Colors.white
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   top: 20,
//                 ),
//                 child: Column(
//                   children: [
//
//                     SettingScreenWidget(
//                         text: AppLocale.selectLanguage.getString(context),
//                         beforeIcon: Icons.language,
//                         onPressed: (){
//
//                         },
//                     ),
//                     Divider(
//                       thickness: MySize.size1,
//                       color: Colors.grey.shade100,
//                     ),
//
//                     SizedBox(height: MySize.size10,),
//
//                     Row(
//                       children: [
//                         Row(
//                           children: [
//                             Icon(Icons.brightness_5, color: Colors.black, size: MySize.size30,),
//                             SizedBox(width: MySize.size15,),
//                             Text(
//                               isThemeDark?AppLocale.darkTheme.getString(context):AppLocale.lightTheme.getString(context),
//                               style: TextStyle(
//                                 fontSize: MySize.size15,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Spacer(),
//                         Transform.scale(
//                           scale: 0.9, // adjust this value to change the size of the switch
//                           child: Switch(
//                             value: isThemeDark,
//                             onChanged: (value) {
//                               setState(() {
//                                 isThemeDark = value;
//                                 // add your theme changing logic here
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     Divider(
//                       thickness: MySize.size1,
//                       color: Colors.grey.shade200,
//                     ),
//                     SizedBox(height: MySize.size10,),
//                     SettingScreenWidget(
//                       text: AppLocale.privacyPolicy.getString(context),
//                       beforeIcon: Icons.privacy_tip_outlined,
//                       onPressed: (){
//
//                       },
//                     ),
//                     Divider(
//                       thickness: MySize.size1,
//                       color: Colors.grey.shade100,
//                     ),
//                     SizedBox(height: MySize.size10,),
//                     SettingScreenWidget(
//                         text: AppLocale.aboutUs.getString(context), beforeIcon: Icons.read_more_outlined, onPressed: (){
//
//                     }),
//                     Divider(
//                       thickness: MySize.size1,
//                       color: Colors.grey.shade100,
//                     ),
//                     SizedBox(height: MySize.size10,),
//
//                   ],
//                 ),
//               ),
//             ),
//
//             // Container(
//             //   padding: EdgeInsets.only(
//             //     left: 15,
//             //     right: 15,
//             //   ),
//             //   width: double.infinity,
//             //   height: MySize.size50,
//             //   decoration: BoxDecoration(
//             //     borderRadius: BorderRadius.only(
//             //       topLeft: Radius.circular(10),
//             //       topRight: Radius.circular(10),
//             //       bottomRight: Radius.circular(10),
//             //       bottomLeft: Radius.circular(10),
//             //     ),
//             //     color: Colors.white
//             //   ),
//             //   child: Column(
//             //     children: [
//             //       Row(
//             //         //mainAxisAlignment: MainAxisAlignment.sta,
//             //         children: [
//             //           Row(
//             //             children: [
//             //               // Container(
//             //               //   height: MySize.size50,
//             //               //   width: MySize.size50,
//             //               //   decoration: BoxDecoration(
//             //               //     shape: BoxShape.circle,
//             //               //     color: Colors.grey.shade100,
//             //               //   ),
//             //               //   child: Icon(Icons.language,color: Colors.black,),
//             //               // ),
//             //
//             //               Icon(Icons.language,color: Colors.black,size: MySize.size40,),
//             //               SizedBox(width: MySize.size15,),
//             //               Text(
//             //                 'Select Language',
//             //                 style: TextStyle(
//             //                   fontSize: MySize.size20,
//             //                   color: Colors.black,
//             //                   fontWeight: FontWeight.bold,
//             //                 ),
//             //               ),
//             //             ],
//             //           ),
//             //           // Text(
//             //           //     'Select Language',
//             //           //   style: TextStyle(
//             //           //     fontSize: MySize.size20,
//             //           //     color: Colors.black,
//             //           //     fontWeight: FontWeight.bold,
//             //           //   ),
//             //           // ),
//             //           Spacer(),
//             //           Icon(Icons.arrow_forward_ios,size: MySize.size20,color: Colors.black,)
//             //
//             //         ],
//             //       ),
//             //     ],
//             //   ),
//             // )
//
//           ],
//         ),
//       )
//
//     );
//   }
// }
