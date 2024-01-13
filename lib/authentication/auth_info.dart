import 'package:flutter/material.dart';

class AuthInfo extends ChangeNotifier {
  String phone = "";
  String password = "";
  String fullName = "";
  String email = "";

  Map<String, dynamic> logedUserInfo = {};
  Map<String, dynamic> registerUserInfo = {};

  void registerUser(Map<String, dynamic> signupInputValue) {
    registerUserInfo = signupInputValue;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    phone = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  void setFullName(String value) {
    fullName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  // Future loginUser(Map<String, dynamic> user) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool result = await prefs.setString("user", jsonEncode(user));
  // }

  // Future logedOutUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool result = await prefs.remove("user");
  // }

  //  Future getUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var result = prefs.getString("user")!;
  //   var userMap = jsonDecode(result);
  //   logedUserInfo = userMap;
  //   notifyListeners();

  // }

  //   Future addCategory(List category) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool result = await prefs.setString("category", jsonEncode(category));
  // }

  // Future clearCategory() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool result = await prefs.remove("category");
  // }

  // Future getCategory() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var result = prefs.getString("category")!;
  //   var categoryMap = jsonDecode(result);
  //   catagoryInfo = categoryMap;
  //   notifyListeners();

  // }
}
