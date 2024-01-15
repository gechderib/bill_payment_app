import 'dart:convert';
import 'package:billpayment/constants/const.dart';
import 'package:billpayment/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  Future createUser(UserModel user) async {
    var header = <String, String>{
      'content-type': 'application/json',
      'X-RapidAPI-Key': '34e56ba814msh455386714d314d5p19b5fajsnd374fd760871',
      'X-RapiRapidAPIdAPI-Host': 'user-auth2.p.rapidapi.com'
    };

    final response = await http.post(
      Uri.parse("$BASE_URL/register"),
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
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 400) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to create user");
    }
  }

  Future loginUser(LoginModel user) async {
    var header = <String, String>{
      'content-type': 'application/json',
      'X-RapidAPI-Key': '34e56ba814msh455386714d314d5p19b5fajsnd374fd760871',
      'X-RapidAPI-Host': 'user-auth2.p.rapidapi.com'
    };

    try {
      final response = await http.post(
        Uri.parse("$BASE_URL/login"),
        headers: header,
        body: jsonEncode(
          <String, dynamic>{"phone": user.phone, "password": user.password},
        ),
      );
      print(response);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to login user");
      }
    } catch (e) {
      print(e);
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
