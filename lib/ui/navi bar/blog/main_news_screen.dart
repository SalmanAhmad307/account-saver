import 'package:account_saver/ui/navi%20bar/blog/blog_catogery_screen.dart';
import 'package:account_saver/ui/navi%20bar/blog/blog_headline_screen.dart';
import 'package:flutter/cupertino.dart';

class MainNewsScreen extends StatefulWidget {
  const MainNewsScreen({super.key});

  @override
  State<MainNewsScreen> createState() => _MainNewsScreenState();
}

class _MainNewsScreenState extends State<MainNewsScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    return Column(
      children: [
        SizedBox(
            width: width,
            height: 260,
            //height: height * 0.30,
            child: const BlogScreen()),
        const Expanded(
            // width: width,
            // height: height * 0.34,
            child: BlogCategoryScreen()),
      ],
    );
  }
}
