import 'package:account_saver/core/constants/app_all_strings.dart';
import 'package:account_saver/core/global_provider/language_theme_provider.dart';
import 'package:account_saver/database/database_provider.dart';
import 'package:account_saver/routes/route_generator.dart';
import 'package:account_saver/routes/routes.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';

final FlutterLocalization localization = FlutterLocalization.instance;

void main() {
  runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(), // Wrap your app
      ),
     // const MyApp()

  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('ar', AppLocale.AR),
        const MapLocale('de', AppLocale.DE),
        const MapLocale('zh', AppLocale.ZH),
        const MapLocale('es', AppLocale.ES),
      ],
      initLanguageCode:'en',
    );
    localization.onTranslatedLanguage = onTranslatedLanguage;



  }

  void onTranslatedLanguage(Locale? locale) {
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(),
        ),
         ChangeNotifierProvider(create:(_)=> LanguageAndThemeProvider()),
      ],
      child:  Consumer<LanguageAndThemeProvider>(

        builder: (BuildContext context, value, Widget? child) {
          return MaterialApp(
            supportedLocales: localization.supportedLocales,
            localizationsDelegates: localization.localizationsDelegates,
            title: 'Accounter ++',
            theme:value.isDarkTheme?ThemeData.dark():ThemeData.light() ,
            initialRoute: Routes.home,
            onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
          );
        }
      ),
    );
  }
}
