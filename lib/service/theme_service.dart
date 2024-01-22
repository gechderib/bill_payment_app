import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  String theme = "Light";

  void toggleTheme(String value) {
    theme = value;
    notifyListeners();
  }
}
