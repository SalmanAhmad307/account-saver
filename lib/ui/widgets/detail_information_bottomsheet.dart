import 'package:account_saver/core/constants/media_query.dart';
import 'package:account_saver/database/database_provider.dart';
import 'package:account_saver/ui/widgets/edit_bank_info_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class DetailInformationBottomsheet extends StatefulWidget {
  final Map<String, dynamic> account;
  final VoidCallback onDelete; // Add delete callback

  const DetailInformationBottomsheet({
    super.key,
    required this.account,
    required this.onDelete, // Require delete callback
  });

  @override
  _BankAccountEditSheetState createState() => _BankAccountEditSheetState();
}

class _BankAccountEditSheetState extends State<DetailInformationBottomsheet> {
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
    MySize().init(context);

    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        // Sync _isFavorite state with provider
        bool _isFavorite = provider.bankAccounts.firstWhere(
              (account) => account['id'] == widget.account['id'],
              orElse: () => {'favorite': 0},
            )['favorite'] ==
            1;

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Color(0xffF0F5F9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: MySize.size60,
                    height: MySize.size4,
                    decoration: BoxDecoration(
                      color: const Color(0xff9EA0A1),
                      borderRadius: BorderRadius.circular(MySize.size2),
                    ),
                  ),
                ),
                SizedBox(
                  height: MySize.size68,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 9, top: 12, bottom: 12, right: 18),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: MySize.size40, // Adjust width for the square
                            height:
                                MySize.size40, // Adjust height for the square
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFFF0F5F9), // Background color
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Icon(
                              Icons
                                  .account_balance, // Replace with your icon/image
                              size: MySize.size30,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(widget.account["account_holder_name"]),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                            provider.toggleFavorite(
                                widget.account['id'], _isFavorite);
                          },
                          child: Icon(
                            Icons.star,
                            color: _isFavorite ? Colors.amber : Colors.grey,
                            size: MySize.size30,
                          ),
                        ), // Star icon
                        const SizedBox(width: 8.0),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => BankAccountEditSheet(
                                account: widget.account,
                              ),
                            );
                          },
                          child: Icon(
                            Icons.edit,
                            size: MySize.size30,
                          ),
                        ), // Edit icon
                        const SizedBox(width: 8.0),
                        PopupMenuButton<String>(
                          icon: Icon(
                            Icons.more_vert,
                            size: MySize.size30,
                            color: Colors.grey,
                          ),
                          onSelected: (value) {
                            if (value == 'delete') {
                              // Handle delete action
                              //_deleteAccount();
                              widget.onDelete();
                              Navigator.pop(context); // Close the bottom sheet
                            } else if (value == 'share') {
                              // Handle share action
                              //_shareAccount();
                              _shareAccount();
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('Delete'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'share',
                              child: Row(
                                children: [
                                  Icon(Icons.share, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text('Share'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Three dots icon
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                _buildInfoContainer(
                  icon: Icons.account_circle,
                  label: "Account Holder Name",
                  value: widget.account["account_holder_name"],
                ),
                const SizedBox(height: 8.0),
                _buildInfoContainer(
                  icon: Icons.account_balance,
                  label: "Bank Name",
                  value: widget.account["bank_name"],
                ),
                const SizedBox(height: 8.0),
                _buildInfoContainer(
                  icon: Icons.format_list_numbered,
                  label: "Account Number",
                  value: widget.account["account_number"],
                ),
                const SizedBox(height: 8.0),
                _buildInfoContainer(
                  icon: Icons.credit_card,
                  label: "IBAN",
                  value: widget.account["iban"],
                ),
                const SizedBox(height: 8.0),
                _buildInfoContainer(
                  icon: Icons.category,
                  label: "Category",
                  value: widget.account["category"],
                ),
                const SizedBox(height: 8.0),
                _buildInfoContainer(
                  icon: Icons.phone,
                  label: "Phone Number",
                  value: widget.account["phone_number"],
                ),
                const SizedBox(height: 8.0),
                _buildInfoContainer(
                  icon: Icons.people,
                  label: "Relation",
                  value: widget.account["relation"],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _shareAccount() {
    final account = widget.account;

    // Format the account information
    final accountInfo = '''
Account Holder Name: ${account['account_holder_name']}
Bank Name: ${account['bank_name']}
Account Number: ${account['account_number']}
IBAN: ${account['iban']}
Phone Number: ${account['phone_number']}
Relation: ${account['relation']}
Category: ${account['category']}
''';

    // Share the account info
    Share.share(
      accountInfo,
      subject: 'Account Information',
    );
  }

  Widget _buildInfoContainer({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 9, top: 12, bottom: 12, right: 18),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: MySize.size40,
            height: MySize.size40,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F5F9),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              icon,
              size: MySize.size30,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
