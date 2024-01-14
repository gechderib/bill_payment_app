import 'package:flutter/material.dart';

class PaymentScreenState extends ChangeNotifier {
  String selectedBill = 'Electricity Bill';
  double paymentAmount = 0.0;

  List<String> bills = ['Electricity Bill', 'Water Bill', 'Internet Bill'];

  void setBill(String bill) {
    selectedBill = bill;
    notifyListeners();
  }

  void setPaymentAmount(double amount) {
    paymentAmount = amount;
    notifyListeners();
  }
}
