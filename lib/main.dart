import 'package:currency_app/helper/app_localizations.dart';
import 'package:currency_app/providers/language_provider.dart';
import 'package:currency_app/providers/currencies.dart';
import 'package:currency_app/providers/theme_provider.dart';
import 'package:currency_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  final LanguageProvider languageProvider = LanguageProvider();
  final ThemeProvider themeProvider = ThemeProvider();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Currencies(),
        ),
        ChangeNotifierProvider.value(
          value: languageProvider,
        ),
        ChangeNotifierProvider(create: (context) => themeProvider),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, theme, language, child) {
      language.fetchLocale();
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Currencies',
        themeMode: theme.getTheme,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.red,
        ),
        locale: language.appLocal,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('fa', ''),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: HomeScreen(),
      );
    });
  }
}
