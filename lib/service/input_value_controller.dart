import 'package:flutter/material.dart';

class InputFieldController extends ChangeNotifier {
  String paymentAmount = "";

  void setPaymenAmount(String value) {
    paymentAmount = value;
    notifyListeners();
  }
}
