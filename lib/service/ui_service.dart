import 'package:flutter/material.dart';

class SplashScreenState extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> loadContent(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    _isLoading = false;
    // Navigator.of(context).pushReplacementNamed('/login');

    notifyListeners();
  }
}

class UiServiceProvider extends ChangeNotifier {
  bool isObsecure = true;
  bool isLoging = false;

  void obsecureText() {
    if (isObsecure) {
      isObsecure = false;
    } else {
      isObsecure = true;
    }
    notifyListeners();
  }
}
