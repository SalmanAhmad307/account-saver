// import 'package:account_saver/core/constants/app_colors.dart';
// import 'package:account_saver/core/constants/media_query.dart';
// import 'package:account_saver/ui/blog/main_news_screen.dart';
// import 'package:account_saver/ui/home/home_screen.dart';
// import 'package:account_saver/ui/widgets/custom_appbar.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;

//   final List<Widget> _screens = [
//     const HomeScreen2(),
//     //const BlogScreen(),
//     const MainNewsScreen(),
//     const SettingsScreen(),
//   ];

//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset:
//           true, // Adjust the view when keyboard is visible

//       // appBar: const CustomAppBar(),
//       backgroundColor: Colors.white,
//       // floatingActionButton: FloatingActionButton(
//       //   backgroundColor: Colors.white,
//       //   onPressed: () {
//       //     showModalBottomSheet(
//       //       context: context,
//       //       builder: (BuildContext context) {
//       //         return const AddBankAccount();
//       //       },
//       //     );
//       //   },
//       //   child: Icon(
//       //     Icons.add,
//       //     size: MySize.size30,
//       //     color: Colors.blueGrey,
//       //   ),
//       // ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _screens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white30,
//         backgroundColor: AppColors.borderColorDark,
//         onTap: _onTabTapped,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.insert_drive_file_outlined),
//             label: 'Blogs',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     MySize().init(context);

//     return Center(
//       child: Text(
//         'Profile Screen',
//         style: TextStyle(color: Colors.white, fontSize: MySize.size20),
//       ),
//     );
//   }
// }

// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     MySize().init(context);

//     return Scaffold(
//       appBar: const CustomAppBar(title: "Settings"),
//       body: Center(
//         child: Text(
//           'Settings Screen',
//           style: TextStyle(color: Colors.white, fontSize: MySize.size20),
//         ),
//       ),
//     );
//   }
// }
import 'package:account_saver/core/constants/app_colors.dart';
import 'package:account_saver/core/constants/media_query.dart';
import 'package:account_saver/ui/blog/main_news_screen.dart';
import 'package:account_saver/ui/home/home_screen.dart';
import 'package:account_saver/ui/widgets/custom_appbar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen2(),
    const MainNewsScreen(),
    const SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom:
                20, // Adjust this value to control how high the app bar floats
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  25.0), // Rounded corners for floating effect
              child: ConvexAppBar(
                backgroundColor: AppColors.borderColorDark,
                height: 70, // Height of the floating app bar
                style: TabStyle.reactCircle, // Animation style
                elevation: 10, // Elevation for a shadow effect
                curveSize: 70, // Decreased curve size for smaller highlight
                top: -4, // Adjust top to fine-tune the highlight position
                items: const [
                  TabItem(icon: Icons.home, title: 'Home'),
                  TabItem(
                      icon: Icons.insert_drive_file_outlined, title: 'Blogs'),
                  TabItem(icon: Icons.settings, title: 'Settings'),
                ],
                initialActiveIndex: _currentIndex,
                onTap: _onTabTapped,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return Scaffold(
      appBar: const CustomAppBar(title: "Settings"),
      body: Center(
        child: Text(
          'Settings Screen',
          style: TextStyle(color: Colors.white, fontSize: MySize.size20),
        ),
      ),
    );
  }
}
