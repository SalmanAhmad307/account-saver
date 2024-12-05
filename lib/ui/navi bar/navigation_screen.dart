import 'package:account_saver/core/constants/app_colors.dart';
import 'package:account_saver/core/constants/app_images.dart';
import 'package:account_saver/core/constants/media_query.dart';

import 'package:account_saver/ui/navi%20bar/home/home_screen.dart';
import 'package:account_saver/ui/navi%20bar/blog/main_news_screen.dart';
import 'package:account_saver/ui/navi%20bar/setting_screen/setting_screen.dart';
import 'package:account_saver/ui/widgets/add_bank_account.dart';
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
    const MainNewsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: _screens[_currentIndex], // Main screen based on selected tab

      bottomNavigationBar: SizedBox(
        height: MySize.size110,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MySize.size80, // Adjusted height of bottom bar
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.bottomNavWhiteModeColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left part of the bottom bar (empty space or any button)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _onTabTapped(0); // Home
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: MySize.size40),
                          child: Center(
                            child: Image.asset(
                              // Conditionally show disabled or enabled icon based on _currentIndex
                              _currentIndex == 0
                                  ? AppImages
                                      .homeIconEnable // Show disabled icon when index is 0
                                  : AppImages
                                      .homeIconDisable, // Show enabled icon when index is not 0
                              width: MySize
                                  .size33, // Set the desired width of the icon
                              height: MySize
                                  .size33, // Set the desired height of the icon
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Right part of the bottom bar (empty space or any button)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _onTabTapped(1); // Settings
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: MySize.size40),
                          child: Center(
                            child: Image.asset(
                              // Conditionally show disabled or enabled icon based on _currentIndex
                              _currentIndex == 0
                                  ? AppImages
                                      .newsIconDisable // Show disabled icon when index is 0
                                  : AppImages
                                      .newIconEnable, // Show enabled icon when index is not 0
                              width: MySize
                                  .size40, // Set the desired width of the icon
                              height: MySize
                                  .size40, // Set the desired height of the icon
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Center "Add" button outside the bottom bar
            Positioned(
              bottom: MySize
                  .size30, // Push it out of the bar by 30 units (adjust as needed)
              left: MediaQuery.of(context).size.width / 2 -
                  35, // Center horizontally
              child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => const AddBankAccount(),
                    );

                    // Your action for Add button here
                  },
                  child: Container(
                    width: MySize.size70, // Set the size of the Add button
                    height: MySize.size70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor, // Customize color
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFFCEEE7), // Shadow color
                          offset: Offset(-3, -3), // Offset for top-left shadow
                          blurRadius: 8, // How much the shadow will blur
                          spreadRadius: 2, // How much the shadow will spread
                        ),
                        BoxShadow(
                          color: Color(0xFFFCEEE7), // Shadow color
                          offset: Offset(3, -3), // Offset for top-right shadow
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      AppImages.addIconEnable, // Your Add icon asset path here
                      width: MySize.size30, // Set the desired width of the icon
                      height:
                          MySize.size30, // Set the desired height of the icon
                    ),
                    //  Icon(
                    //   Icons.add,
                    //   color: Colors.white,
                    //   size: 30,
                    // ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
