import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  MaterialColor themeColor = Colors.blue; // Default theme color

  ThemeData getTheme() {
    return ThemeData(
      primarySwatch: themeColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  void setThemeColor(MaterialColor newColor) {
    themeColor = newColor;
    notifyListeners();
  }
}
