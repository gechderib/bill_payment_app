import 'dart:convert';
import 'dart:io';
import 'package:billpayment/constants/variables/const.dart';
import 'package:billpayment/models/bill.dart';
import 'package:billpayment/models/transaction.dart';
import 'package:billpayment/models/user.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  var uiProvider = UiServiceProvider();

  Future createUser(UserModel user) async {
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
        return json.decode(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        await uiProvider.showToast("Not registered", Colors.red, Colors.white);
        throw Exception("Failed to create user: ${response.statusCode}");
      } else {
        throw Exception("Failed to create user");
      }
    } catch (e) {
      handleAuthError(e);
    }
  }

  Future loginUser(
    LoginModel loginInfo,
  ) async {
    var header = <String, String>{
      'content-type': 'application/json',
      // 'X-ACCESS-TOKEN': 'SMAPL',
    };
    try {
      final response = await http.get(
          Uri.parse(
              "$BASE_URL/users?phone=${loginInfo.phone}&password=${loginInfo.password}"),
          headers: header);
      print(loginInfo.phone);
      print(loginInfo.password);
      if (response.statusCode == 200) {
        final List<dynamic> users = json.decode(response.body);
        print(users);
        print("------------------------");
        if (users.isNotEmpty) {
          await uiProvider.showToast(
              "Login successful", Colors.green, Colors.white);
          return UserModel.fromJson(users[0]);
        } else {
          await uiProvider.showToast(
              "Please register first", Colors.red, Colors.white);
          throw Exception('User not found');
        }
      } else {
        throw Exception("Failed to login user");
      }
    } catch (e) {
      handleAuthError(e);
    }
  }

  Future changePassword(String userId, String newPassword) async {
    try {
      var header = <String, String>{
        'content-type': 'application/json',
        // 'X-acess-token': 'sampelto',
      };
      final response = await http.patch(
        Uri.parse(
          "$BASE_URL/users/$userId",
        ),
        headers: header,
        body: jsonEncode(
          <String, dynamic>{
            "password": newPassword,
          },
        ),
      );
      if (response.statusCode == 200) {
        await uiProvider.showToast(
            "Password successful updated", Colors.greenAccent, Colors.white);
        return json.decode(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        await uiProvider.showToast(
            "Password not updated", Colors.redAccent, Colors.white);
        return json.decode(response.body);
      }
    } catch (e) {
      handleAuthError(e);
      throw Exception("failed to pay bill");
    }
  }

  void handleAuthError(dynamic e) async {
    if (e is SocketException) {
      await uiProvider.showToast(
          "Please check your connection", Colors.red, Colors.white);
    } else if (e is HttpException) {
      await uiProvider.showToast(
          "Server error, please try again", Colors.red, Colors.white);
    } else if (e is FormatException) {
      await uiProvider.showToast(
          "Please check your data", Colors.red, Colors.white);
    }
    print(e);
    throw Exception('Failed to auth user');
  }
}

class BillProvider extends ChangeNotifier {
  var uiProvider = UiServiceProvider();

  Future<List<Bill>> getUserBills(String userId) async {
    var header = <String, String>{
      'content-type': 'application/json',
      // 'X-access-token': '43',
    };
    try {
      final response = await http.get(
        Uri.parse("$BASE_URL/bills"),
        headers: header,
      );
      if (response.statusCode == 200) {
        List<dynamic> userBillsData = json.decode(response.body);
        List<Bill> userBills = userBillsData
            .where((userBill) => userBill["userId"] == userId)
            .map((userBill) => Bill.fromJson(userBill))
            .toList();
        return userBills;
      } else if (response.statusCode == 400) {
        // Handle error response if needed
        throw Exception("Failed to fetch bills: ${json.decode(response.body)}");
      }
    } catch (e) {
      throw Exception("Failed to get bills: $e");
    }

    // Return an empty list if no bills or an error occurred
    return [];
  }

  Future getOneUserBill(String bill_id) async {
    try {
      var header = <String, String>{
        'content-type': 'application/json',
        // 'X-access-token': '43',
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

  Future completPendingTransactions(String transaction_id) async {
    try {
      var header = <String, String>{
        'content-type': 'application/json',
        // 'X-acess-token': 'sampelto',
      };
      final response = await http.patch(
        Uri.parse(
          "$BASE_URL/transactions/$transaction_id",
        ),
        headers: header,
        body: jsonEncode(
          <String, dynamic>{
            "status": "completed",
            "dueDate": DateTime.now().toString()
          },
        ),
      );
      if (response.statusCode == 200) {
        await uiProvider.showToast(
            "Transaction successful", Colors.greenAccent, Colors.white);
        return json.decode(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        await uiProvider.showToast(
            "Transaction not completed", Colors.redAccent, Colors.white);
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
      throw Exception("failed to pay bill");
    }
  }

  Future payBill(String bill_id, Transaction transaction) async {
    try {
      var header = <String, String>{
        'content-type': 'application/json',
        // 'X-acess-token': 'sampelto',
      };
      final response = await http.patch(
        Uri.parse(
          "$BASE_URL/bills/$bill_id",
        ),
        headers: header,
        body: jsonEncode(<String, dynamic>{"status": "completed"}),
      );
      if (response.statusCode == 200) {
        final transactionRes = await http.post(
          Uri.parse(
            "$BASE_URL/transactions",
          ),
          headers: header,
          body: jsonEncode(<String, dynamic>{
            "name": transaction.name,
            "amount": transaction.amount,
            "dueDate": transaction.dueDate,
            "status": transaction.status,
            "userId": transaction.userId
          }),
        );
        if (transactionRes.statusCode == 201) {
          await uiProvider.showToast(
              "Transaction successful", Colors.greenAccent, Colors.white);
          return json.decode(response.body);
        } else if (response.statusCode == 400 ||
            transactionRes.statusCode == 400 ||
            response.statusCode == 401 ||
            transactionRes.statusCode == 401) {
          await uiProvider.showToast(
              "Transaction not completed", Colors.redAccent, Colors.white);
          return json.decode(response.body);
        }
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        await uiProvider.showToast(
            "Bill not paid", Colors.redAccent, Colors.white);
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception("failed to pay bill");
    }
  }
}

class TransactionProvider extends ChangeNotifier {
  var uiProvider = UiServiceProvider();

  Future getAllTransactions(String userId) async {
    try {
      var header = <String, String>{
        'content-type': 'application/json',
        // 'X-access-toek': '5432',
      };
      final response =
          await http.get(Uri.parse("$BASE_URL/transactions"), headers: header);
      if (response.statusCode == 200) {
        List<dynamic> userTransactions = json
            .decode(response.body)
            .where((userBill) => userBill["userId"] == userId)
            .toList();
        return userTransactions;
      } else if (response.statusCode == 400) {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception("failed to pay bill");
    }
  }

  Future getOneTransaction(String transaction_id) async {
    try {
      var header = <String, String>{
        'content-type': 'application/json',
        // 'X-access-token': '4884',
      };
      final response = await http.get(
          Uri.parse("$BASE_URL/transactions/$transaction_id"),
          headers: header);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        await uiProvider.showToast(
            "Data not found", Colors.redAccent, Colors.white);
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        await uiProvider.showToast(
            "Data not found", Colors.redAccent, Colors.white);
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception("failed to pay bill");
    }
  }
}
