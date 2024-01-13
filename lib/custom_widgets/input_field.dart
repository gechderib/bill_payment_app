import 'package:billpayment/constants/styles/decoration.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextInputField extends StatelessWidget {
  const CustomTextInputField(
      {super.key,
      required this.onValueChnage,
      required this.hint,
      required this.valueControler,
      this.textInputType,
      this.onValidate,
      required this.decoration});

  final String hint;
  final Function(String) onValueChnage;
  final Function(String)? onValidate;
  final TextInputType? textInputType;
  final TextEditingController valueControler;
  final InputDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        onValueChnage(value);
      },
      keyboardType: textInputType,
      decoration: decoration.copyWith(hintText: hint),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Invalid input";
        }
        return null;
      },
    );
  }
}

class CustomPasswordInputField extends StatelessWidget {
  const CustomPasswordInputField(
      {Key? key,
      required this.onValueChnage,
      required this.hint,
      required this.valueController,
      required this.decoration})
      : super(key: key);
  final String hint;
  final Function(String) onValueChnage;
  final TextEditingController valueController;
  final InputDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return Consumer<UiServiceProvider>(builder: (context, uiProvider, _) {
      return TextFormField(
        onChanged: (value) {
          onValueChnage(value);
        },
        obscureText: uiProvider.isObsecure,
        decoration: decoration.copyWith(
          suffixIcon: IconButton(
              onPressed: () {
                uiProvider.obsecureText();
              },
              icon: const Icon(
                Icons.remove_red_eye,
                color: Color(0XFF606060),
              )),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Password Field cant be empty";
          }
          if (value.length < 6) {
            return "The password must be at least 6 characters";
          }
          return null;
        },
      );
    });
  }
}
