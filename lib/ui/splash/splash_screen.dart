import 'package:account_saver/core/constants/media_query.dart';
import 'package:account_saver/ui/navi%20bar/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
        return const NavigationScreen();
      }));
    });
  }

  // @override
  // void dispose() {
  //   _controller!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Icon(Icons.file_copy_outlined,color: Colors.white, size: MySize.size60,),
          SizedBox(height: MySize.size20,),
          Align(
            alignment: Alignment.center,
            child: Text('Welcome to \n Account Saver',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: MySize.size40,
            ),
            ),
          ),

        ],
      ),
    );
  }
}
