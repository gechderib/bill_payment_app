import 'dart:convert';

import 'package:billpayment/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future addloginUserInfo(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", jsonEncode(user.toJson()));
  }

  Future logedOutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user");
  }

  Future getLoginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getString("user")!;
    var userMap = jsonDecode(result);
    logedUserInfo = userMap;
    notifyListeners();
  }
}
