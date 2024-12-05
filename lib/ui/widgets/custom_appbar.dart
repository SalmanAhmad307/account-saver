import 'package:account_saver/core/constants/app_images.dart';
import 'package:account_saver/core/constants/media_query.dart';
import 'package:account_saver/core/global_provider/language_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final String title; // Add a title parameter

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Consumer<LanguageAndThemeProvider>(
      builder: (context,viewModel,child){
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: MySize.size16), // Padding for the container
          //height: 80.0, // Height of the custom app bar
          decoration:  BoxDecoration(
            color:Colors.white
          ),
          child: Row(
            children: [
              // Drawer icon
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: SizedBox(
                  width: MySize.size25, // Set the size of the drawer icon
                  height: MySize.size25,
                  child: Image.asset(
                    AppImages.drawerIcon,
                    fit: BoxFit.contain, // Ensure the icon scales proportionally
                  ),
                ),
              ),
              SizedBox(width: MySize.size16), // Spacing between the icon and title
              // Title
              Expanded(
                child: Text(
                  title, // Use the title parameter
                  style: GoogleFonts.inter(
                    fontSize: MySize.size18,
                    color: Colors.black54,
                  ),
                ),
              ),
              // Action icons
              IconButton(
                icon: Icon(
                  Icons.star,
                  color: Colors.black,
                  size: MySize.size30,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/favorites');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: MySize.size30,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
