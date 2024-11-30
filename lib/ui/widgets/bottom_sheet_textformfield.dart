import 'package:account_saver/core/constants/media_query.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const BottomSheetTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator, // Validator is optional
    this.keyboardType = TextInputType.text, // Default to text input
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Padding(
      padding: EdgeInsets.only(
        left: MySize.size16,
        right: MySize.size16,
      ), // Adjust padding as needed
      child: GestureDetector(
        onTap: () {
          // Remove focus to prevent any keyboard popup
          FocusScope.of(context).unfocus();
        },
        child: TextFormField(
          controller: controller, // Use the provided controller
          validator: validator, // Assign the validator function
          keyboardType: keyboardType, // Use the specified keyboard type
          decoration: InputDecoration(
            hintText: hintText, // Placeholder text
            hintStyle: GoogleFonts.inter(
              fontSize: 16.0, // Font size
              fontWeight: FontWeight.w500, // Font weight
              color: Colors.black54, // Hint text color
            ),
            filled: true,
            fillColor: Colors.white, // Background color
            contentPadding: EdgeInsets.symmetric(
              vertical: MySize.size22,
              horizontal: MySize.size22,
            ), // Padding inside the field
            border: InputBorder.none, // Removes the border line
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none, // No border when enabled
              borderRadius: BorderRadius.circular(15), // Circular border radius
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none, // No border when focused
              borderRadius: BorderRadius.circular(15), // Circular border radius
            ),
          ),
          style: GoogleFonts.inter(
            fontSize: 18.0, // Font size
            fontWeight: FontWeight.w500, // Font weight
          ),
        ),
      ),
    );
  }
}
