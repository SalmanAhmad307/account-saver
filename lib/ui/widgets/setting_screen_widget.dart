import 'package:account_saver/core/constants/media_query.dart';
import 'package:flutter/material.dart';

class SettingScreenWidget extends StatelessWidget {
  final String text;
  final IconData beforeIcon;
  final VoidCallback onPressed;
  const SettingScreenWidget(
      {
        super.key,
      required this.text,
      required this.beforeIcon,
      required this.onPressed
      });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Row(
      //mainAxisAlignment: MainAxisAlignment.sta,
      children: [
        Row(
          children: [
            // Container(
            //   height: MySize.size50,
            //   width: MySize.size50,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Colors.grey.shade100,
            //   ),
            //   child: Icon(Icons.language,color: Colors.black,),
            // ),

            Icon(
              beforeIcon,
              color: Colors.black,
              size: MySize.size30,
            ),
            SizedBox(
              width: MySize.size15,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: MySize.size15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // Text(
        //     'Select Language',
        //   style: TextStyle(
        //     fontSize: MySize.size20,
        //     color: Colors.black,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        Spacer(),
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            Icons.arrow_forward_ios,
            size: MySize.size20,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
