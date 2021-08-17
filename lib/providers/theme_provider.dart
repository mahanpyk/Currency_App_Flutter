import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  var _themeMode = ThemeMode.light;

  get getTheme => _themeMode;

  setTheme(themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
