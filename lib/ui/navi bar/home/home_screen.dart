import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../database/database_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:account_saver/core/constants/app_colors.dart';
import 'package:account_saver/core/constants/media_query.dart';
import 'package:account_saver/ui/widgets/custom_appbar.dart';
import 'package:account_saver/ui/widgets/search_textformfield.dart';
import '../../widgets/bank_account_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _fetchData;
  String? _selectedCategory;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _fetchData = _loadData();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  Future<void> _loadData() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    await provider.fetchBankAccounts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CustomAppBar(title: "Home"),
            SizedBox(height: MySize.size20),
            Padding(
              padding: EdgeInsets.only(left: MySize.size16),
              child: CustomTextFormField(
                controller: _searchController,
                //hintText: "Search by Name or Bank",
              ),
            ),
            SizedBox(height: MySize.size20),
            Padding(
              padding: EdgeInsets.only(left: MySize.size16),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance,
                    size: MySize.size24,
                    color: Colors.grey[700],
                  ),
                  SizedBox(width: MySize.size15),
                  Text(
                    "Bank Accounts",
                    style: GoogleFonts.inter(
                      fontSize: MySize.size16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MySize.size20),
            _buildCategoryChips(),
            Expanded(
              child: Consumer<DatabaseProvider>(
                builder: (context, provider, _) {
                  // Filter accounts by category and search query
                  List<Map<String, dynamic>> filteredAccounts =
                      provider.bankAccounts.where((account) {
                    final matchesCategory = _selectedCategory == null ||
                        account['category'] == _selectedCategory;
                    final matchesSearch = account['account_holder_name']
                            .toString()
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()) ||
                        account['bank_name']
                            .toString()
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase());
                    return matchesCategory && matchesSearch;
                  }).toList();

                  return FutureBuilder<void>(
                    future: _fetchData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (filteredAccounts.isEmpty) {
                        return Center(
                          child: Text(
                            "No accounts found",
                            style: GoogleFonts.inter(
                              fontSize: MySize.size16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff343333),
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: MySize.size16),
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
                                accountHolderName:
                                    account["account_holder_name"] ?? "n/a",
                                bankName: account["bank_name"] ?? "n/a",
                                account: account,
                              );
                            },
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    final categories = [
      "All",
      "Personal",
      "Family",
      "Business",
      "Friends",
      "Other"
    ];
    return Padding(
      padding: EdgeInsets.only(left: MySize.size16),
      child: SizedBox(
        height: MySize.size40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            String category = categories[index];
            bool isSelected = _selectedCategory == category ||
                (category == "All" && _selectedCategory == null);

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: MySize.size8),
              child: FilterChip(
                label: Text(
                  category,
                  style: GoogleFonts.inter(
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory =
                        selected ? (category == "All" ? null : category) : null;
                  });
                },
                selectedColor: AppColors.categoryChipColor,
                backgroundColor: Color(0xFFF0F5F9),
                showCheckmark: false,
                side: BorderSide.none,
              ),
            );
          },
        ),
      ),
    );
  }
}
