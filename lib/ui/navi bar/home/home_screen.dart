import 'package:account_saver/core/constants/app_colors.dart';
import 'package:account_saver/core/constants/media_query.dart';
import 'package:account_saver/ui/home/home_screen.dart';
import 'package:account_saver/ui/widgets/custom_appbar.dart';
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
    const ProfileScreen(),
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
      resizeToAvoidBottomInset:
          true, // Adjust the view when keyboard is visible

      appBar: const CustomAppBar(),
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
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white30,
        backgroundColor: AppColors.borderColorDark,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file_outlined),
            label: 'Blogs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(color: Colors.white, fontSize: MySize.size20),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return Center(
      child: Text(
        'Settings Screen',
        style: TextStyle(color: Colors.white, fontSize: MySize.size20),
      ),
    );
  }
}
