import 'package:account_saver/core/constants/media_query.dart';
import 'package:account_saver/main.dart';
import 'package:account_saver/ui/widgets/custom_appbar.dart';
import 'package:account_saver/ui/widgets/setting_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_all_strings.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isThemeDark = false;
  String currentLanguageCode = 'en'; // Default language code
  String selectedLanguage = 'English'; // Default language name

  final List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en', 'flag': '🇬🇧'},
    {'name': 'Arabic', 'code': 'ar', 'flag': '🇸🇦'},
    {'name': 'German', 'code': 'de', 'flag': '🇩🇪'},
    {'name': 'Chinese', 'code': 'zh', 'flag': '🇨🇳'},
    {'name': 'Spanish', 'code': 'es', 'flag': '🇪🇸'},
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage(); // Load saved language on initialization
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
                          localization.translate(
                              language['code']!); // Apply language change
                        });
                        _saveSelectedLanguage(
                            language['code']!); // Save language preference
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

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      //appBar: CustomAppBar(title: AppLocale.setting.getString(context)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: MySize.size20),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _showLanguageDialog(context),
                      child: SettingScreenWidget(
                        text:
                            '${AppLocale.selectLanguage.getString(context)} ($selectedLanguage)',
                        beforeIcon: Icons.language,
                      ),
                    ),
                    Divider(
                      thickness: MySize.size1,
                      color: Colors.grey.shade100,
                    ),
                    SizedBox(height: MySize.size10),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.brightness_5,
                                color: Colors.black, size: MySize.size30),
                            SizedBox(width: MySize.size15),
                            Text(
                              isThemeDark
                                  ? AppLocale.darkTheme.getString(context)
                                  : AppLocale.lightTheme.getString(context),
                              style: TextStyle(
                                fontSize: MySize.size15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Transform.scale(
                          scale: 0.9,
                          child: Switch(
                            value: isThemeDark,
                            onChanged: (value) {
                              setState(() {
                                isThemeDark = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: MySize.size1,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(height: MySize.size10),
                    SettingScreenWidget(
                      text: AppLocale.privacyPolicy.getString(context),
                      beforeIcon: Icons.privacy_tip_outlined,
                      onPressed: () {},
                    ),
                    Divider(
                      thickness: MySize.size1,
                      color: Colors.grey.shade100,
                    ),
                    SizedBox(height: MySize.size10),
                    SettingScreenWidget(
                      text: AppLocale.aboutUs.getString(context),
                      beforeIcon: Icons.read_more_outlined,
                      onPressed: () {},
                    ),
                    Divider(
                      thickness: MySize.size1,
                      color: Colors.grey.shade100,
                    ),
                    SizedBox(height: MySize.size10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
