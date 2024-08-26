// import 'package:account_saver/ui/widgets/custom_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../database/database_provider.dart';
// import '../widgets/add_bank_account.dart';
// import '../widgets/bank_account_tile.dart';

// class HomeScreen2 extends StatefulWidget {
//   const HomeScreen2({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomeScreen2State createState() => _HomeScreen2State();
// }

// class _HomeScreen2State extends State<HomeScreen2> {
//   late Future<void> _fetchData;
//   String? _selectedCategory; // Track the selected category

//   @override
//   void initState() {
//     super.initState();
//     _fetchData = _loadData();
//   }

//   Future<void> _loadData() async {
//     final provider = Provider.of<DatabaseProvider>(context, listen: false);
//     await provider.fetchBankAccounts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//             appBar: const CustomAppBar(title: "Home") ,
//       backgroundColor: Colors.white,
//       body: Consumer<DatabaseProvider>(
//         builder: (context, provider, child) {
//           List<Map<String, dynamic>> filteredAccounts = _selectedCategory ==
//                   null
//               ? provider.bankAccounts
//               : provider.bankAccounts
//                   .where((account) => account['category'] == _selectedCategory)
//                   .toList();

//           return FutureBuilder<void>(
//             future: _fetchData,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (provider.bankAccounts.isEmpty) {
//                 return const Center(child: Text('No data available.'));
//               } else {
//                 return Column(
//                   children: [
//                     // Category Chips
//                     SizedBox(
//                       height: 60,
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           _buildCategoryChip(context, 'All'),
//                           _buildCategoryChip(context, 'Personal'),
//                           _buildCategoryChip(context, 'Family'),
//                           _buildCategoryChip(context, 'Business'),
//                           _buildCategoryChip(context, 'Friends'),
//                           _buildCategoryChip(context, 'Other'),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: filteredAccounts.length,
//                         itemBuilder: (context, index) {
//                           final account = filteredAccounts[index];
//                           return BankAccountTile(
//                             accountNumber: account['account_number'],
//                             category: account['category'],
//                             iban: account['iban'],
//                             relation: account['relation'],
//                             phoneNumber: account['phone_number'],
//                             // onShare: () {
//                             //   // Implement share functionality here
//                             // },
//                             onDelete: () async {
//                               final provider = Provider.of<DatabaseProvider>(
//                                   context,
//                                   listen: false);
//                               await provider.deleteBankAccount(
//                                   account['id']); // Pass the ID to delete
//                             },
//                             accountHolderName:
//                                 account["account_holder_name"] ?? "n/a",
//                             bankName: account["bank_name"] ?? "n/a",
//                             account: account,
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               }
//             },
//           );
//         },
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showModalBottomSheet(
//             context: context,
//             builder: (context) => const AddBankAccount(),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildCategoryChip(BuildContext context, String category) {
//     bool isSelected = _selectedCategory == category ||
//         (category == 'All' && _selectedCategory == null);

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: FilterChip(
//         label: Text(
//           category,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.black,
//           ),
//         ),
//         selected: isSelected,
//         onSelected: (selected) {
//           setState(() {
//             _selectedCategory = selected
//                 ? (category == 'All' ? null : category)
//                 : _selectedCategory;
//           });
//         },
//         selectedColor: Colors.black,
//         backgroundColor: Colors.grey[200],
//         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//         showCheckmark: false,
//       ),
//     );
//   }
// }

import 'package:account_saver/core/constants/app_colors.dart';
import 'package:account_saver/ui/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../database/database_provider.dart';
import '../widgets/add_bank_account.dart';
import '../widgets/bank_account_tile.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  late Future<void> _fetchData;
  String? _selectedCategory; // Track the selected category

  @override
  void initState() {
    super.initState();
    _fetchData = _loadData();
  }

  Future<void> _loadData() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    await provider.fetchBankAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(title: "Home"),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Consumer<DatabaseProvider>(
            builder: (context, provider, child) {
              List<Map<String, dynamic>> filteredAccounts = _selectedCategory ==
                      null
                  ? provider.bankAccounts
                  : provider.bankAccounts
                      .where(
                          (account) => account['category'] == _selectedCategory)
                      .toList();

              return FutureBuilder<void>(
                future: _fetchData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (provider.bankAccounts.isEmpty) {
                    return const Center(child: Text('No data available.'));
                  } else {
                    return Column(
                      children: [
                        // Category Chips
                        SizedBox(
                          height: 60,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildCategoryChip(context, 'All'),
                              _buildCategoryChip(context, 'Personal'),
                              _buildCategoryChip(context, 'Family'),
                              _buildCategoryChip(context, 'Business'),
                              _buildCategoryChip(context, 'Friends'),
                              _buildCategoryChip(context, 'Other'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: filteredAccounts.length,
                            itemBuilder: (context, index) {
                              final account = filteredAccounts[index];
                              return BankAccountTile(
                                accountNumber: account['account_number'],
                                category: account['category'],
                                iban: account['iban'],
                                relation: account['relation'],
                                phoneNumber: account['phone_number'],
                                onDelete: () async {
                                  final provider =
                                      Provider.of<DatabaseProvider>(context,
                                          listen: false);
                                  await provider.deleteBankAccount(
                                      account['id']); // Pass the ID to delete
                                },
                                accountHolderName:
                                    account["account_holder_name"] ?? "n/a",
                                bankName: account["bank_name"] ?? "n/a",
                                account: account,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              );
            },
          ),
          Positioned(
            bottom: 120, // Adjust the value to move the FAB upward
            right: 30,
            child: FloatingActionButton(
              backgroundColor: AppColors.borderColorDark,
              foregroundColor: Colors.white,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const AddBankAccount(),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String category) {
    bool isSelected = _selectedCategory == category ||
        (category == 'All' && _selectedCategory == null);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: FilterChip(
        label: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = selected
                ? (category == 'All' ? null : category)
                : _selectedCategory;
          });
        },
        selectedColor: Colors.black,
        backgroundColor: Colors.grey[200],
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        showCheckmark: false,
      ),
    );
  }
}
