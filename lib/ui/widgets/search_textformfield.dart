import 'package:account_saver/core/constants/media_query.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
final TextEditingController controller;

    const CustomTextFormField({
    super.key,
    required this.controller // Default to text input
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Padding(
      padding: EdgeInsets.all(MySize.size16), // Adjust padding as needed
      child: GestureDetector(
        onTap: () {
          // Remove focus to prevent any keyboard popup
          FocusScope.of(context).unfocus();
          // Navigate to the search page
          Navigator.pushNamed(context, '/search');
        },
        child: TextFormField(
          controller: controller,
//          readOnly: true, // Makes the field non-editable
          decoration: InputDecoration(
            hintText: 'Search...', // Placeholder text
            hintStyle: GoogleFonts.inter(
              fontSize: 18.0, // Font size
              fontWeight: FontWeight.w500, // Font weight
              color: Colors.black54, // Hint text color
            ),
            prefixIcon:
                const Icon(Icons.search, color: Colors.grey), // Search icon
            filled: true,
            fillColor: const Color(0xFFF0F5F9), // Background color
            contentPadding: EdgeInsets.symmetric(
                vertical: MySize.size10,
                horizontal: MySize.size20), // Padding inside the field
            border: InputBorder.none, // Removes the border line
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none, // No border when enabled
              borderRadius: BorderRadius.circular(30), // Circular border radius
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none, // No border when focused
              borderRadius: BorderRadius.circular(30), // Circular border radius
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
