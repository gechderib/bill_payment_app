class UserModel {
  UserModel(
      {this.fullName, this.email, required this.phone, required this.password});

  String? fullName;
  String? email;
  String phone;
  String password;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        fullName: json["fullName"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"]);
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
