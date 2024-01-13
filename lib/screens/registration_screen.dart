import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  TextEditingController full_name_controller = TextEditingController();
  TextEditingController email_ontroller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController confirm_password_ontroller = TextEditingController();
  TextEditingController phone_number_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Registration scree  "),
    );
  }
}
