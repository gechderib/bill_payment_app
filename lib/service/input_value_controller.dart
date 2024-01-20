import 'package:flutter/material.dart';

class InputFieldControllerProvider extends ChangeNotifier {
  double paymentAmount = 0;

  void setPaymenAmount(double value) {
    paymentAmount = value;
    notifyListeners();
  }
}
