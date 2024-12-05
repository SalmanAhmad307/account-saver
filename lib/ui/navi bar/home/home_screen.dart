import 'package:account_saver/core/constants/app_all_strings.dart';
import 'package:account_saver/core/global_provider/language_theme_provider.dart';
import 'package:account_saver/main.dart';
import 'package:account_saver/ui/navi%20bar/setting_screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool isThemeDark = false;
  String currentLanguageCode = 'en'; // Default language code
  String selectedLanguage = 'English'; // Default language name
  String currentFlag = '🇬🇧';
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
      child: Consumer<LanguageAndThemeProvider>(
        builder: (context, viewModel, child) {
          return Scaffold(
            //backgroundColor: Colors.white38,
            drawer: Drawer(
              width: MySize.size300,
               backgroundColor:const Color(0xffF0F5F9) ,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 20,
                ),
                child: Column(
                  children: [
                    Text(
                      AppLocale.setting.getString(context),
                      style: TextStyle(
                        color:
                            viewModel.isDarkTheme ? Colors.white : Colors.black,
                        fontSize: MySize.size20,
                      ),
                    ),
                    SizedBox(
                      height: MySize.size20,
                    ),
                    Container(
                      width: MySize.size250,
                      //height: MySize.size170,
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Colors.white70,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: MySize.size20,
                          ),
                          GestureDetector(
                            onTap: () => _showLanguageDialog(context),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  currentFlag,
                                  style: TextStyle(
                                    fontSize: MySize.size18,
                                  ),
                                ),
                                SizedBox(
                                  width: MySize.size20,
                                ),
                                Text(
                                  selectedLanguage,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: MySize.size15, // Adjust font size for the title
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: MySize.size20,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MySize.size25,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.privacy_tip_outlined,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MySize.size20,
                              ),
                              Text(
                                AppLocale.privacyPolicy.getString(context),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MySize.size15, // Adjust font size for the title
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: MySize.size20,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MySize.size25,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.read_more_outlined,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MySize.size20,
                              ),
                              Text(
                                AppLocale.aboutUs.getString(context),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MySize
                                      .size15, // Adjust font size for the title
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: MySize.size20,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MySize.size15,
                          ),
                          Row(
                            children: [
                              SizedBox(width: MySize.size10,),
                              Icon(
                                Provider.of<LanguageAndThemeProvider>(context)
                                        .isDarkTheme
                                    ? Icons.nightlight_round
                                    : Icons.wb_sunny,
                                size: MySize
                                    .size18, // Reduce the size of the secondary icon
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MySize.size20,
                              ),
                              Text(
                                isThemeDark
                                    ? AppLocale.darkTheme.getString(context)
                                    : AppLocale.lightTheme.getString(context),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MySize
                                      .size13, // Adjust font size for the title
                                ),
                              ),
                              const Spacer(),
                              Transform.scale(
                                scale: 0.5, // Reduce the size of the switch
                                child: Switch(
                                  value: Provider.of<LanguageAndThemeProvider>(
                                          context)
                                      .isDarkTheme,
                                  onChanged: (value) {
                                    Provider.of<LanguageAndThemeProvider>(
                                            context,
                                            listen: false)
                                        .toggleTheme(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                const CustomAppBar(title: "Home"),
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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: MySize.size16),
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
          );
        },
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
                backgroundColor: const Color(0xFFF0F5F9),
                showCheckmark: false,
                side: BorderSide.none,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentLanguageCode = prefs.getString('selected_language_code') ?? 'en';
      selectedLanguage = languages.firstWhere(
              (lang) => lang['code'] == currentLanguageCode)['name'] ??
          'English';
    });
  }

  Future<void> _saveSelectedLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language_code', languageCode);
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocale.selectLanguage.getString(context)),
          content: SingleChildScrollView(
            child: Column(
              children: languages
                  .map(
                    (language) => ListTile(
                      leading: Text(language['flag']!),
                      title: Text(language['name']!),
                      onTap: () {
                        setState(() {
                          selectedLanguage = language['name']!;
                          currentLanguageCode = language['code']!;
                          currentFlag = language['flag']!;
                          localization.translate(language['code']!);
                        });
                        _saveSelectedLanguage(language['code']!);
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  final List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en', 'flag': '🇬🇧'},
    {'name': 'Arabic', 'code': 'ar', 'flag': '🇸🇦'},
    {'name': 'German', 'code': 'de', 'flag': '🇩🇪'},
    {'name': 'Chinese', 'code': 'zh', 'flag': '🇨🇳'},
    {'name': 'Spanish', 'code': 'es', 'flag': '🇪🇸'},
  ];
}
