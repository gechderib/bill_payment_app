import 'package:billpayment/models/bill.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UiServiceProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool isObsecure = true;
  bool isLoging = false;

  int prevActiveIndex = 0;
  int activeTabIndex = 0;

  double safeAreaHeight = 0;

  String detail_transaction_id = "";
  String detail_bill_id = "";

  dynamic selectedBill = {
    'id': '1Eg5',
    'name': 'Electric',
    'amount': 895.7,
    'dueDate': DateTime.parse('2024-01-19 19:09:06.111043'),
    'status': 'completed',
    'userId': 'c62f',
  };

  // void setBill(Bill bill) {
  //   selectedBill = bill;
  //   notifyListeners();
  // }

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
    if (activeTabIndex > 0) {
      prevActiveIndex = activeTabIndex - 1;
    }
    notifyListeners();
  }

  void changeIsLoging(bool loging) {
    isLoging = loging;
    notifyListeners();
  }

  Future showToast(String message, Color backgroundColor, Color textColor) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_LEFT,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 16.0);
  }
}
