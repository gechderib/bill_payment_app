import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/models/bill.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UiServiceProvider extends ChangeNotifier {
  AuthInfo authInfo = AuthInfo();
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool isObsecure = true;
  bool isLoging = false;

  int prevActiveIndex = 0;
  int activeTabIndex = 0;

  double safeAreaHeight = 0;

  String detail_transaction_id = "";
  String detail_bill_id = "";

  Bill? selectedBill = null;

  String forgotPasswordPhone = "251953890542";

  List<dynamic> filteredTransactions = [];

  void setSelectedBill(Bill? bill) {
    selectedBill = bill;
    notifyListeners();
  }

  void filterTransactions(String query, List<dynamic> transactions) {
    filteredTransactions = transactions.where((transaction) {
      return transaction["name"].toLowerCase().contains(query.toLowerCase()) ||
          transaction["status"].toLowerCase().contains(query.toLowerCase());
    }).toList();

    notifyListeners();
  }

  Future<void> loadContent(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
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
