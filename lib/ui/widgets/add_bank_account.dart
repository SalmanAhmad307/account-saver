import 'package:account_saver/core/constants/media_query.dart';
import 'package:flutter/material.dart';
class AddBankAccount extends StatelessWidget {
  const AddBankAccount({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Container(
      height: MySize.size400,
        width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topRight:Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        color: Colors.blueGrey,
      ),

      child: Column(
        children: [
          Text('Add Bank Account Number',style: TextStyle(color: Colors.white,fontSize: MySize.size20),),
        ],
      ),
    );
  }
}
