import 'package:account_saver/core/constants/app_all_strings.dart';
import 'package:account_saver/core/constants/app_colors.dart';
import 'package:account_saver/core/constants/app_images.dart';
import 'package:account_saver/core/constants/media_query.dart';
import 'package:account_saver/ui/widgets/custom_appbar.dart';
import 'package:account_saver/ui/widgets/search_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../database/database_provider.dart';
import '../../widgets/bank_account_tile.dart';
import 'package:flutter_localization/flutter_localization.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    MySize().init(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                CustomAppBar(title: AppLocale.home.getString(context)),
                SizedBox(height: MySize.size30),
                const CustomTextFormField(),
                SizedBox(height: MySize.size15),

                Padding(
                  padding: EdgeInsets.only(left: MySize.size16),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.bankIcon,
                        height: MySize.size23,
                        width: MySize.size23,
                      ),
                      SizedBox(width: MySize.size15),
                      Text(
                        "Bank Accounts",
                        style: GoogleFonts.inter(
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff343333),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MySize.size15,
                ),
                // Category Chips
                Padding(
                  padding: EdgeInsets.only(left: MySize.size16),
                  child: SizedBox(
                    height: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategoryChip(
                            context, AppLocale.all.getString(context)),
                        _buildCategoryChip(
                            context, AppLocale.personal.getString(context)),
                        _buildCategoryChip(
                            context, AppLocale.family.getString(context)),
                        _buildCategoryChip(
                            context, AppLocale.business.getString(context)),
                        _buildCategoryChip(
                            context, AppLocale.friends.getString(context)),
                        _buildCategoryChip(
                            context, AppLocale.other.getString(context)),
                      ],
                    ),
                  ),
                ),
                // Consumer to show the filtered data
                Consumer<DatabaseProvider>(
                  builder: (context, provider, child) {
                    List<Map<String, dynamic>> filteredAccounts =
                        _selectedCategory == null
                            ? provider.bankAccounts
                            : provider.bankAccounts
                                .where((account) =>
                                    account['category'] == _selectedCategory)
                                .toList();

                    return FutureBuilder<void>(
                      future: _fetchData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (provider.bankAccounts.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: MySize.size16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: MySize
                                          .size60), // Adjust to add space from the top
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFF0F5F9), // Circle color
                                    ),
                                    padding: const EdgeInsets.all(
                                        8.0), // Optional padding around the image
                                    child: ClipOval(
                                      child: Image.asset(
                                        AppImages.bankImage, // Your image
                                        fit: BoxFit
                                            .cover, // Ensure the image fits within the circle
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: MySize
                                          .size30), // Adjust to add space between image and text
                                  Text(
                                    AppLocale.noDataAvailable
                                        .getString(context),
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(
                                          0xff343333), // Adjust text color as needed
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: MySize.size16,
                                //top: MySize.size16
                              ),
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
                                    // onDelete: () async {
                                    //   final provider =
                                    //       Provider.of<DatabaseProvider>(context,
                                    //           listen: false);
                                    //   await provider.deleteBankAccount(account[
                                    //       'id']); // Pass the ID to delete
                                    // },
                                    accountHolderName:
                                        account["account_holder_name"] ?? "n/a",
                                    bankName: account["bank_name"] ?? "n/a",
                                    account: account,
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            // FloatingActionButton
            // Positioned(
            //   bottom: 50, // Adjust the value to move the FAB upward
            //   right: 30,
            //   child: FloatingActionButton(
            //     backgroundColor: AppColors.borderColorDark,
            //     foregroundColor: Colors.white,
            //     onPressed: () {
            //       showModalBottomSheet(
            //         context: context,
            //         builder: (context) => const AddBankAccount(),
            //       );
            //     },
            //     child: const Icon(Icons.add),
            //   ),
            // ),
          ],
        ),
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
          style: GoogleFonts.inter(
              fontSize: MySize.size15, fontWeight: FontWeight.w500),
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = selected
                ? (category == 'All' ? null : category)
                : _selectedCategory;
          });
        },
        selectedColor: AppColors.categoryChipColor,
        backgroundColor: const Color(0xFFF0F5F9),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        showCheckmark: false,
        // Remove border when unselected
        side: BorderSide.none, // This removes the border
      ),
    );
  }
}
