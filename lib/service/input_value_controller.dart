import 'package:flutter/material.dart';

class InputFieldControllerProvider extends ChangeNotifier {
  double paymentAmount = 0;
  TextEditingController paymentController = TextEditingController();

  void setPaymenAmount(double value) {
    paymentAmount = value;
    notifyListeners();
  }

  void setPaymentController(double value) {
    paymentController.text = value.toString();
  }
}
