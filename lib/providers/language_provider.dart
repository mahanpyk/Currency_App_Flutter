import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Locale? _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale("en");
  fetchLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code')!);
    return Null;
  }


  void changeLanguage(Locale type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("fa")) {
      _appLocale = Locale("fa");
      await prefs.setString('language_code', 'fa');
      await prefs.setString('countryCode', '');
    } else {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
