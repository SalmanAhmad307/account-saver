// import 'package:account_saver/core/constants/app_all_strings.dart';
// import 'package:account_saver/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localization/flutter_localization.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class MainScreenWithDrawer extends StatefulWidget {
//   @override
//   _MainScreenWithDrawerState createState() => _MainScreenWithDrawerState();
// }
//
// class _MainScreenWithDrawerState extends State<MainScreenWithDrawer> {
//   bool isThemeDark = false;
//   String currentLanguageCode = 'en'; // Default language code
//   String selectedLanguage = 'English'; // Default language name
//
//   final List<Map<String, String>> languages = [
//     {'name': 'English', 'code': 'en', 'flag': '🇬🇧'},
//     {'name': 'Arabic', 'code': 'ar', 'flag': '🇸🇦'},
//     {'name': 'German', 'code': 'de', 'flag': '🇩🇪'},
//     {'name': 'Chinese', 'code': 'zh', 'flag': '🇨🇳'},
//     {'name': 'Spanish', 'code': 'es', 'flag': '🇪🇸'},
//   ];
//
//   Future<void> _loadSelectedLanguage() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       currentLanguageCode = prefs.getString('selected_language_code') ?? 'en';
//       selectedLanguage = languages.firstWhere(
//               (lang) => lang['code'] == currentLanguageCode)['name'] ??
//           'English';
//     });
//   }
//
//   Future<void> _saveSelectedLanguage(String languageCode) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('selected_language_code', languageCode);
//   }
//
//   void _showLanguageDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(AppLocale.selectLanguage.getString(context)),
//           content: SingleChildScrollView(
//             child: Column(
//               children: languages
//                   .map(
//                     (language) => ListTile(
//                   leading: Text(language['flag']!),
//                   title: Text(language['name']!),
//                   onTap: () {
//                     setState(() {
//                       selectedLanguage = language['name']!;
//                       currentLanguageCode = language['code']!;
//                       localization.translate(language['code']!);
//                     });
//                     _saveSelectedLanguage(language['code']!);
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               )
//                   .toList(),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSelectedLanguage();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Main Screen"),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(color: Colors.blue),
//               child: Text(
//                 'Settings',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.language),
//               title: Text(
//                   '${AppLocale.selectLanguage.getString(context)} ($selectedLanguage)'),
//               onTap: () => _showLanguageDialog(context),
//             ),
//             SwitchListTile(
//               title: Text(isThemeDark
//                   ? AppLocale.darkTheme.getString(context)
//                   : AppLocale.lightTheme.getString(context)),
//               value: isThemeDark,
//               onChanged: (value) {
//                 setState(() {
//                   isThemeDark = value;
//                 });
//               },
//               secondary: const Icon(Icons.brightness_5),
//             ),
//             ListTile(
//               leading: const Icon(Icons.privacy_tip_outlined),
//               title: Text(AppLocale.privacyPolicy.getString(context)),
//               onTap: () {
//                 // Handle privacy policy action
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.read_more_outlined),
//               title: Text(AppLocale.aboutUs.getString(context)),
//               onTap: () {
//                 // Handle about us action
//               },
//             ),
//           ],
//         ),
//       ),
//       body: const Center(
//         child: Text('Main Screen Content'),
//       ),
//     );
//   }
// }
