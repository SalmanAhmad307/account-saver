import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LanguageAndThemeProvider with ChangeNotifier {

   bool _isDarkTheme = false; // Default to light theme
  bool get isDarkTheme => _isDarkTheme;
  LanguageAndThemeProvider() {
    getLocale();
    // getTheme();
  }
  Locale? _appLocale;
  Locale? get appLocale => _appLocale;

  // static final ThemeData lightTheme = ThemeData(
  //     primaryColor: AppColors.primaryColor,
  //     hintColor: AppColors.blackColor,
  //     brightness: Brightness.light,
  //     appBarTheme: const AppBarTheme(
  //       backgroundColor: Colors.transparent,
  //       foregroundColor: AppColors.blackColor,
  //         elevation: 0,
  //
  //         //backgroundColor: AppColors.authBackgroundScreenAndAppBarColor
  //     ),
  //     textTheme: TextTheme(
  //         bodyMedium: TextStyle(
  //           fontSize:MySize.size20,
  //           color: AppColors.blackColor,
  //           fontWeight: FontWeight.w500,
  //           fontFamily: "Ageo",
  //         ),
  //
  //     )
  //   // Add your light theme properties here
  // );
//   static final ThemeData lightTheme = ThemeData(
//     scaffoldBackgroundColor: AppColors.authBackgroundScreenAndAppBarColor,
//     primaryColor: AppColors.primaryColor,
//
//     // primarySwatch: blueSwatch,
//
//     colorScheme:  ColorScheme.light(
//       primary: AppColors.primaryColor,
//       secondary: AppColors.secondaryColor,
//       //surface: AppColors.surfaceColor,
//       primaryContainer: AppColors.primaryColor,
//       secondaryContainer: AppColors.secondaryColor,
//       //tertiaryContainer: AppColors.homeButtonSecondStateColor,
//     ),
//
//     ///
//     useMaterial3: false,
//     appBarTheme:  AppBarTheme(
//       backgroundColor: AppColors.authBackgroundScreenAndAppBarColor,
//       foregroundColor: AppColors.secondaryColor,
//       elevation: 0,
//     ),
//     floatingActionButtonTheme:  FloatingActionButtonThemeData(
//       backgroundColor: AppColors.secondaryColor,
//     ),
//     bottomAppBarTheme:  BottomAppBarTheme(
//       color: AppColors.primaryColor,
//     ),
//     // tabBarTheme: TabBarTheme(
//     //
//     // ),
//
//     textTheme: TextTheme(
//       headlineLarge: GoogleFonts.ropaSans(
//         fontWeight: FontWeight.w400,
//         fontSize: 31.px,
//         color: AppColors.secondaryColor,
//       ),
//       headlineMedium: GoogleFonts.ropaSans(
//         fontWeight: FontWeight.w400,
//         fontSize: 15.px,
//         color: AppColors.secondaryColor,
//       ),
//       headlineSmall: GoogleFonts.poppins(
//         fontWeight: FontWeight.w600,
//         fontSize: 20.px,
//         color: AppColors.secondaryColor,
//       ),
//       titleLarge: GoogleFonts.roboto(
//         fontWeight: FontWeight.w700,
//         fontSize: 15.px,
//         color: AppColors.secondaryColor,
//       ),
// //       titleMedium: GoogleFonts.poppins(
// //         fontWeight: FontWeight.w400,
// //         fontSize: 14.px,
// //         color: Colors.white,
// //       ),
//       titleSmall: GoogleFonts.poppins(
//         fontWeight: FontWeight.w300,
//         fontSize: 21.px,
//         color: AppColors.secondaryColor,
//       ),
//       bodySmall: GoogleFonts.roboto(
//         fontWeight: FontWeight.w600,
//         fontSize: 15.px,
//         color: AppColors.secondaryColor,
//       ),
//       bodyMedium: GoogleFonts.poppins(
//         fontWeight: FontWeight.w600,
//         fontSize: 18.px,
//         color: AppColors.whiteColor,
//       ),
//       bodyLarge: GoogleFonts.roboto(
//         fontWeight: FontWeight.w600,
//         fontSize: 18.px,
//         color: AppColors.secondaryColor,
//       ),
//
//       titleMedium: GoogleFonts.roboto(
//         fontWeight: FontWeight.w600,
//         fontSize: 18.px,
//         color: AppColors.secondaryColor,
//       ),
//     ),
//     cardColor: AppColors.secondaryColor,
//     // colorScheme: ColorScheme.fromSwatch(),
//   );
//
//   static final ThemeData darkTheme = ThemeData(
//     scaffoldBackgroundColor: AppColors.darkModeScaffoldColor,
//     primaryColor: AppColors.primaryColor,
//
//
//     // primarySwatch: blueSwatch,
//
//     colorScheme:  ColorScheme.dark(
//       primary: AppColors.primaryColor,
//       secondary: AppColors.secondaryColor,
//       //surface: AppColors.surfaceColor,
//       //Card Color
//       primaryContainer: AppColors.primaryColor,
//       secondaryContainer: AppColors.secondaryColor,
//       tertiaryContainer: AppColors.darkModeContainerColor,
//     ),
//
//     useMaterial3: false,
//     appBarTheme:  AppBarTheme(
//       backgroundColor: AppColors.darkModeScaffoldColor,
//       foregroundColor: AppColors.primaryColor,
//       elevation: 0,
//     ),
//     floatingActionButtonTheme:  FloatingActionButtonThemeData(
//       backgroundColor: AppColors.primaryColor,
//     ),
//     bottomAppBarTheme:  BottomAppBarTheme(
//       color: AppColors.primaryColor,
//     ),
//
//     // tabBarTheme: TabBarTheme(
//     //
//     // ),
//
//     textTheme: TextTheme(
//       headlineLarge: GoogleFonts.ropaSans(
//         fontWeight: FontWeight.w400,
//         fontSize: 31.px,
//         color: AppColors.whiteColor,
//       ),
//       headlineMedium: GoogleFonts.ropaSans(
//         fontWeight: FontWeight.w400,
//         fontSize: 15.px,
//         color: AppColors.whiteColor,
//       ),
//       headlineSmall: GoogleFonts.poppins(
//         fontWeight: FontWeight.w600,
//         fontSize: 20.px,
//         color: AppColors.whiteColor,
//       ),
//       titleLarge: GoogleFonts.roboto(
//         fontWeight: FontWeight.w700,
//         fontSize: 15.px,
//         color: AppColors.whiteColor,
//       ),
// //       titleMedium: GoogleFonts.poppins(
// //         fontWeight: FontWeight.w400,
// //         fontSize: 14.px,
// //         color: Colors.white,
// //       ),
//       titleSmall: GoogleFonts.poppins(
//         fontWeight: FontWeight.w300,
//         fontSize: 21.px,
//         color: AppColors.whiteColor,
//       ),
//       bodySmall: GoogleFonts.roboto(
//         fontWeight: FontWeight.w600,
//         fontSize: 15.px,
//         color: AppColors.whiteColor,
//       ),
//       bodyMedium: GoogleFonts.roboto(
//         fontWeight: FontWeight.w600,
//         fontSize: 15.px,
//         color: AppColors.secondaryColor,
//       ),
//       bodyLarge: GoogleFonts.roboto(
//         fontWeight: FontWeight.w600,
//         fontSize: 15.px,
//         color: AppColors.whiteColor,
//       ),
//
//       titleMedium: GoogleFonts.roboto(
//         fontWeight: FontWeight.w600,
//         fontSize: 18.px,
//         color: AppColors.primaryColor,
//       ),
//     ),
//     cardColor: AppColors.primaryColor,
//     // colorScheme: ColorScheme.fromSwatch(),
//   );

  // ThemeData _currentTheme = lightTheme;
  //ThemeData get currentTheme => _currentTheme;

  void toggleTheme(bool value) async {
    _isDarkTheme = !_isDarkTheme;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _isDarkTheme);
    notifyListeners();
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  setTheme(String themeName) async {
    SharedPreferences themePreferences = await SharedPreferences.getInstance();
    await themePreferences.setString('theme', themeName);
  }

  // void onThemeChanged(bool value) async {
  //   _currentTheme = value ? darkTheme : lightTheme;
  //   await setTheme(value ? 'dark' : 'light');
  //   notifyListeners();
  // }

  // Future<void> getTheme() async {
  //   SharedPreferences themePreferences = await SharedPreferences.getInstance();
  //   String? savedTheme = themePreferences.getString('theme');
  //   if (savedTheme == 'dark') {
  //     onThemeChanged(true);
  //   }
  // }

  setLocale(String value) {
    _appLocale = Locale(value);
    notifyListeners();
  }

  Future<void> getLocale() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String languageCode =
        sharedPreferences.getString('language_code') ?? '';
    setLocale(languageCode);
  }

  void changeLanguage(Locale type) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _appLocale = type;
    await sharedPreferences.setString('language_code', type.languageCode);
    notifyListeners();
  }
}