import 'package:uuid/uuid.dart';

class UserModel {
  UserModel({
    this.id,
    this.fullName,
    this.email,
    required this.phone,
    required this.password,
  });

  String? id;
  String? fullName;
  String? email;
  String phone;
  String password;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        fullName: json["fullName"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullName": fullName,
      "email": email,
      "phone": phone,
      "password": password
    };
  }
}

class LoginModel {
  LoginModel({required this.phone, required this.password});
  String phone;
  String password;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(phone: json["phone"], password: json["password"]);
  }
}
