import 'package:billpayment/constants/variables/enums.dart';

class Bill {
  Bill({
    this.id,
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.status,
    required this.userId,
  });

  String? id;
  String name;
  double amount;
  DateTime dueDate;
  String status;
  String userId;

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json["id"],
      name: json["name"],
      amount: json["amount"],
      dueDate: json["dueDate"],
      status: json["status"],
      userId: json["userId"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "amout": amount,
      "dueDate": dueDate,
      "status": status,
      "userId": userId
    };
  }
}
