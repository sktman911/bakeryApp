import 'package:doan/customeThemes.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData lightTheme = CustomThemes.lightTheme;
  ThemeData darkTheme = CustomThemes.darkTheme;

  ThemeData _currentTheme = CustomThemes.lightTheme;

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme =
        _currentTheme == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}