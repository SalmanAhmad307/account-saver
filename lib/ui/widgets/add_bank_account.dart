import 'package:account_saver/core/constants/app_all_strings.dart';
import 'package:account_saver/core/constants/app_colors.dart';
import 'package:account_saver/core/constants/media_query.dart';
import 'package:account_saver/database/database_provider.dart';
import 'package:account_saver/ui/widgets/bottom_sheet_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddBankAccount extends StatefulWidget {
  const AddBankAccount({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddBankAccountState createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCategory;
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();

  final FocusNode _accountNumberFocusNode = FocusNode();
  final FocusNode _ibanFocusNode = FocusNode();
  final FocusNode _relationFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  @override
  void dispose() {
    _accountNumberController.dispose();
    _ibanController.dispose();
    _relationController.dispose();
    _phoneNumberController.dispose();
    _accountNumberFocusNode.dispose();
    _ibanFocusNode.dispose();
    _relationFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  Future<void> _addBankAccount() async {
    if (_formKey.currentState?.validate() ?? false) {
      final provider = Provider.of<DatabaseProvider>(context, listen: false);
      final newAccount = {
        'category': selectedCategory,
        'account_number': _accountNumberController.text,
        'iban': _ibanController.text,
        'relation': _relationController.text,
        'phone_number': _phoneNumberController.text,
        'account_holder_name': _accountNameController.text,
        'bank_name': _bankNameController.text,
        'favorite': 0
      };
      await provider.addBankAccount(newAccount);

      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Close the bottom sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      AppLocale.personal.getString(context),
      AppLocale.family.getString(context),
      AppLocale.business.getString(context),
      AppLocale.friends.getString(context),
      AppLocale.other.getString(context),
    ];
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppColors.bottomSheetBackgroundColor,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xff9EA0A1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              //const SizedBox(height: 16),
              // Text(
              //   AppLocale.addBankAccounts.getString(context),
              //   style: TextStyle(color: Colors.white, fontSize: 20),
              //   textAlign: TextAlign.center,
              // ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(
                  left: MySize.size16,
                  right: MySize.size16,
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedCategory,
                  dropdownColor: Colors.blueGrey, // Dropdown background color
                  decoration: InputDecoration(
                    labelText: AppLocale.category.getString(context),
                    labelStyle: GoogleFonts.inter(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white, // Label text color
                    ),
                    filled: true,
                    fillColor: Colors.white, // Background color of the dropdown
                    contentPadding: EdgeInsets.symmetric(
                      vertical: MySize.size22, // Vertical padding for text
                      horizontal: MySize.size22, // Horizontal padding for text
                    ),
                    border: InputBorder.none, // Removes the border line
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none, // No border when enabled
                      borderRadius:
                          BorderRadius.circular(15), // Circular border radius
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none, // No border when focused
                      borderRadius:
                          BorderRadius.circular(15), // Circular border radius
                    ),
                  ),
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: GoogleFonts.inter(
                          fontSize: 16.0, // Font size of dropdown options
                          fontWeight: FontWeight.w500,
                          color: Colors.black, // Text color in dropdown options
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              BottomSheetTextFormField(
                controller: _accountNameController,
                hintText: //   AppLocale.addBankAccounts.getString(context),
               "Account Holder Name",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              BottomSheetTextFormField(
                controller: _bankNameController,
                hintText: "Bank Name",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 5),
              BottomSheetTextFormField(
                controller: _accountNumberController,
                hintText: "Add Account Number",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              BottomSheetTextFormField(
                controller: _ibanController,
                hintText: "Add IBAN Number",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              BottomSheetTextFormField(
                controller: _relationController,
                hintText: "Relation With Account Holder",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              BottomSheetTextFormField(
                controller: _phoneNumberController,
                hintText: "Phone Number",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xffF5D5C6), // Background color of the button
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _addBankAccount,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text widget
                        Text(
                          AppLocale.add.getString(context),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white), // Text color is white
                        ),
                        const SizedBox(
                            width:
                                20), // Space between text and the vertical line
                        // Container as vertical line
                        Container(
                          width: 2, // Line thickness
                          height: 24, // Height of the vertical line
                          color: const Color(
                              0xffEBC0AC), // Color of the vertical line
                        ),
                        const SizedBox(
                            width: 8), // Space between vertical line and icon
                        // Icon widget
                        const Icon(
                          Icons.add,
                          color: Colors.white, // Icon color is white
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
