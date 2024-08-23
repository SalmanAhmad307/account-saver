import 'package:account_saver/database/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankAccountEditSheet extends StatefulWidget {
  final Map<String, dynamic> account;

  const BankAccountEditSheet({super.key, required this.account});

  @override
  // ignore: library_private_types_in_public_api
  _BankAccountEditSheetState createState() => _BankAccountEditSheetState();
}

class _BankAccountEditSheetState extends State<BankAccountEditSheet> {
  final _formKey = GlobalKey<FormState>();
  String? selectedCategory;
  late TextEditingController _accountNumberController;
  late TextEditingController _ibanController;
  late TextEditingController _relationController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _accountNameController;
  late TextEditingController _bankNameController;

  final List<String> categories = [
    'Personal',
    'Family',
    'Business',
    'Friends',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.account['category'];
    _accountNumberController =
        TextEditingController(text: widget.account['account_number']);
    _ibanController = TextEditingController(text: widget.account['iban']);
    _relationController =
        TextEditingController(text: widget.account['relation']);
    _phoneNumberController =
        TextEditingController(text: widget.account['phone_number']);
    _accountNameController =
        TextEditingController(text: widget.account['account_holder_name']);
    _bankNameController =
        TextEditingController(text: widget.account['bank_name']);
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    _ibanController.dispose();
    _relationController.dispose();
    _phoneNumberController.dispose();
    _accountNameController.dispose();
    _bankNameController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState?.validate() ?? false) {
      final provider = Provider.of<DatabaseProvider>(context, listen: false);
      final updatedAccount = {
        'category': selectedCategory,
        'account_number': _accountNumberController.text,
        'iban': _ibanController.text,
        'relation': _relationController.text,
        'phone_number': _phoneNumberController.text,
        'account_holder_name': _accountNameController.text,
        'bank_name': _bankNameController.text,
        'favorite':
            widget.account['favorite'], // Keep the original favorite status
      };
      await provider.editBankAccount(widget.account['id'], updatedAccount);
      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Close the bottom sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
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
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Edit Bank Account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                dropdownColor: Colors.blueGrey[800],
                decoration: const InputDecoration(
                  labelText: 'Category',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyanAccent),
                  ),
                ),
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category,
                        style: const TextStyle(color: Colors.white)),
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
              const SizedBox(height: 16),
              _buildTextField(
                controller: _accountNameController,
                label: 'Name of account holder',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _bankNameController,
                label: 'Bank name',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _accountNumberController,
                label: 'Account Number',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _ibanController,
                label: 'IBAN Account Number',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _relationController,
                label: 'Relation',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _phoneNumberController,
                label: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _saveChanges,
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyanAccent),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
