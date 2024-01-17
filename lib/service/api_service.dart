import 'dart:convert';
import 'dart:io';
import 'package:billpayment/constants/const.dart';
import 'package:billpayment/models/user.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  final uiProvider = UiServiceProvider();
  Future createUser(UserModel user) async {
    uiProvider.changeIsLoging(true);
    var header = <String, String>{
      'content-type': 'application/json',
      // 'x-access-token': '',
    };

    try {
      final response = await http.post(
        Uri.parse("$BASE_URL/users/"),
        headers: header,
        body: jsonEncode(
          <String, dynamic>{
            "fullName": user.fullName,
            "email": user.email,
            "phone": user.phone,
            "password": user.password
          },
        ),
      );
      if (response.statusCode == 201) {
        await uiProvider.showToast(
            "Successfully registered", Colors.green, Colors.white);
        uiProvider.changeIsLoging(true);
        return json.decode(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        await uiProvider.showToast("Not registered", Colors.red, Colors.white);
        throw Exception("Failed to create user: ${response.statusCode}");
      } else {
        throw Exception("Failed to create user");
      }
    } catch (e) {
      if (e is SocketException) {
        await uiProvider.showToast(
            "Please check your connection", Colors.red, Colors.white);
        uiProvider.changeIsLoging(true);
      } else if (e is HttpException) {
        await uiProvider.showToast(
            "Server error try again", Colors.red, Colors.white);
        uiProvider.changeIsLoging(true);
      } else if (e is FormatException) {
        await uiProvider.showToast(
            "Please check your data", Colors.red, Colors.white);
        uiProvider.changeIsLoging(true);
      }
      throw Exception("Failed to create user");
    }
  }

  Future loginUser(LoginModel loginInfo) async {
    var header = <String, String>{
      'content-type': 'application/json',
      // 'X-ACCESS-TOKEN': 'SMAPL',
    };

    try {
      final user = await http.get(Uri.parse(
          "$BASE_URL/users?phone=${loginInfo.phone}?password=${loginInfo.password}"));

      final response = await http.post(
        Uri.parse("$BASE_URL/login"),
        headers: header,
        body: jsonEncode(
          <String, dynamic>{
            "phone": loginInfo.phone,
            "password": loginInfo.password
          },
        ),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to login user");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel> checkUserExistence(UserModel user) async {
    try {
      final response = await http.get(
        Uri.parse(
            "$BASE_URL/users?phone=${user.phone}?password=${user.password}"),
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body)[0]);
      } else if (response.statusCode == 404) {
        throw Exception('User not found');
      } else {
        print('Received unexpected status code: ${response.statusCode}');
        throw Exception('Failed to retrieve user');
      }
    } catch (e) {
      if (e is SocketException) {
        await uiProvider.showToast(
            "Please check your connection", Colors.red, Colors.white);
        uiProvider.changeIsLoging(true);
      } else if (e is HttpException) {
        await uiProvider.showToast(
            "Server error try again", Colors.red, Colors.white);
        uiProvider.changeIsLoging(true);
      } else if (e is FormatException) {
        await uiProvider.showToast(
            "Please check your data", Colors.red, Colors.white);
        uiProvider.changeIsLoging(true);
      }
      throw Exception("Failed to create user");
    }
  }
}

class BillProvider extends ChangeNotifier {
  Future getUserBills() async {
    var header = <String, String>{
      'content-type': 'application/json',
      'X-RapidAPI-Key': '34e56ba814msh455386714d314d5p19b5fajsnd374fd760871',
      'X-RapidAPI-Host': 'user-auth2.p.rapidapi.com'
    };
    try {
      final response = await http.get(
        Uri.parse("$BASE_URL/bills"),
        headers: header,
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception("failed to get bills");
    }
  }

  Future getOneUserBill(String bill_id) async {
    try {
      var header = <String, String>{
        'content-type': 'application/json',
        'X-RapidAPI-Key': '34e56ba814msh455386714d314d5p19b5fajsnd374fd760871',
        'X-RapidAPI-Host': 'user-auth2.p.rapidapi.com'
      };
      final response = await http.get(
        Uri.parse("$BASE_URL/bills/$bill_id"),
        headers: header,
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception("failed to get bill");
    }
  }

  Future payBill(String bill_id) async {
    try {
      var header = <String, String>{
        'content-type': 'application/json',
        'X-RapidAPI-Key': '34e56ba814msh455386714d314d5p19b5fajsnd374fd760871',
        'X-RapidAPI-Host': 'user-auth2.p.rapidapi.com'
      };
      final response = await http.post(
        Uri.parse(
          "$BASE_URL/paybill/$bill_id",
        ),
        headers: header,
        body: <String, dynamic>{"amount": 76},
      );
      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception("failed to pay bill");
    }
  }
}

class TransactionProvider extends ChangeNotifier {
  Future getAllTransactions() async {
    try {
      var header = <String, String>{
        'content-type': 'application/json',
        'X-RapidAPI-Key': '34e56ba814msh455386714d314d5p19b5fajsnd374fd760871',
        'X-RapidAPI-Host': 'user-auth2.p.rapidapi.com'
      };
      final response =
          await http.get(Uri.parse("$BASE_URL/transactions"), headers: header);
      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception("failed to pay bill");
    }
  }

  Future getOneTransaction(transaction_id) async {
    try {
      var header = <String, String>{
        'content-type': 'application/json',
        'X-RapidAPI-Key': '34e56ba814msh455386714d314d5p19b5fajsnd374fd760871',
        'X-RapidAPI-Host': 'user-auth2.p.rapidapi.com'
      };
      final response = await http.get(
          Uri.parse("$BASE_URL/transaaction/$transaction_id"),
          headers: header);
      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception("failed to pay bill");
    }
  }
}

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
