// import 'package:account_saver/ui/home/navigation_screen.dart';
// import 'package:account_saver/ui/navi%20bar/blog/main_news_screen.dart';
// import 'package:account_saver/ui/navi%20bar/setting_screen/setting_screen.dart';
// import 'package:flutter/material.dart';
// class CustomBottomNavigationBar extends StatefulWidget {
//   const CustomBottomNavigationBar({super.key});
//
//   @override
//   _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
// }
//
// class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   final List<Widget> _screens = [
//     const HomeScreen2(),
//     //const BlogScreen(),
//     const MainNewsScreen(),
//     const SettingScreen(),
//   ];
//   int _currentIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = _screens[index] as int;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       decoration: BoxDecoration(
//         border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(0, -3),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildNavItem(Icons.home, 'Home', 0),
//           _buildNavItem(Icons.settings, 'Settings', 1),
//           _buildNavItem(Icons.info, 'About', 2),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNavItem(IconData icon, String label, int index) {
//     return GestureDetector(
//       onTap: () {
//         _onItemTapped(index);
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             size: 24,
//             color: _currentIndex == index ? Colors.blue : Colors.grey,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: _currentIndex == index ? Colors.blue : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }