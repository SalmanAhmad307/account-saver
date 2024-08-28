import 'package:account_saver/core/constants/media_query.dart';
import 'package:account_saver/ui/widgets/custom_appbar.dart';
import 'package:account_saver/ui/widgets/setting_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../core/constants/app_all_strings.dart';
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isThemeDark=false;
  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: const CustomAppBar(title: "Settings"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MySize.size20,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 10,
                ),
                width: double.infinity,
                //sheight: MySize.size200,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // color of shadow
                        spreadRadius: 5, // spread radius of the shadow
                        blurRadius: 7, // blur radius of the shadow
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Column(
                    children: [

                      SettingScreenWidget(
                        text: AppLocale.selectLanguage.getString(context),
                        beforeIcon: Icons.language,
                        onPressed: (){

                        },
                      ),
                      Divider(
                        thickness: MySize.size1,
                        color: Colors.grey.shade100,
                      ),

                      SizedBox(height: MySize.size10,),

                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.brightness_5, color: Colors.black, size: MySize.size30,),
                              SizedBox(width: MySize.size15,),
                              Text(
                                isThemeDark?AppLocale.darkTheme.getString(context):AppLocale.lightTheme.getString(context),
                                style: TextStyle(
                                  fontSize: MySize.size15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Transform.scale(
                            scale: 0.9, // adjust this value to change the size of the switch
                            child: Switch(
                              value: isThemeDark,
                              onChanged: (value) {
                                setState(() {
                                  isThemeDark = value;
                                  // add your theme changing logic here
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: MySize.size1,
                        color: Colors.grey.shade200,
                      ),
                      SizedBox(height: MySize.size10,),
                      SettingScreenWidget(
                        text: AppLocale.privacyPolicy.getString(context),
                        beforeIcon: Icons.privacy_tip_outlined,
                        onPressed: (){

                        },
                      ),
                      Divider(
                        thickness: MySize.size1,
                        color: Colors.grey.shade100,
                      ),
                      SizedBox(height: MySize.size10,),
                      SettingScreenWidget(
                          text: AppLocale.aboutUs.getString(context), beforeIcon: Icons.read_more_outlined, onPressed: (){

                      }),
                      Divider(
                        thickness: MySize.size1,
                        color: Colors.grey.shade100,
                      ),
                      SizedBox(height: MySize.size10,),

                    ],
                  ),
                ),
              ),

              // Container(
              //   padding: EdgeInsets.only(
              //     left: 15,
              //     right: 15,
              //   ),
              //   width: double.infinity,
              //   height: MySize.size50,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(10),
              //       topRight: Radius.circular(10),
              //       bottomRight: Radius.circular(10),
              //       bottomLeft: Radius.circular(10),
              //     ),
              //     color: Colors.white
              //   ),
              //   child: Column(
              //     children: [
              //       Row(
              //         //mainAxisAlignment: MainAxisAlignment.sta,
              //         children: [
              //           Row(
              //             children: [
              //               // Container(
              //               //   height: MySize.size50,
              //               //   width: MySize.size50,
              //               //   decoration: BoxDecoration(
              //               //     shape: BoxShape.circle,
              //               //     color: Colors.grey.shade100,
              //               //   ),
              //               //   child: Icon(Icons.language,color: Colors.black,),
              //               // ),
              //
              //               Icon(Icons.language,color: Colors.black,size: MySize.size40,),
              //               SizedBox(width: MySize.size15,),
              //               Text(
              //                 'Select Language',
              //                 style: TextStyle(
              //                   fontSize: MySize.size20,
              //                   color: Colors.black,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           // Text(
              //           //     'Select Language',
              //           //   style: TextStyle(
              //           //     fontSize: MySize.size20,
              //           //     color: Colors.black,
              //           //     fontWeight: FontWeight.bold,
              //           //   ),
              //           // ),
              //           Spacer(),
              //           Icon(Icons.arrow_forward_ios,size: MySize.size20,color: Colors.black,)
              //
              //         ],
              //       ),
              //     ],
              //   ),
              // )

            ],
          ),
        )

    );
  }
}
