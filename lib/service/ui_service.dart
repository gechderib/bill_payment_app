import 'package:flutter/material.dart';

class UiServiceProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool isObsecure = true;
  bool isLoging = false;

  int activeTabIndex = 0;

  Future<void> loadContent(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    _isLoading = false;
    notifyListeners();
  }

  void obsecureText() {
    if (isObsecure) {
      isObsecure = false;
    } else {
      isObsecure = true;
    }
    notifyListeners();
  }

  void changeIndex(int index) async {
    activeTabIndex = index;
    notifyListeners();
  }
}
