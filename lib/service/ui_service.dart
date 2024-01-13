import 'package:flutter/material.dart';

class UiServiceProvider extends ChangeNotifier {}

class SplashScreenState extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> loadContent() async {
    await Future.delayed(Duration(seconds: 2));
    _isLoading = false;
    notifyListeners();
  }
}
