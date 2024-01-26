import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextInputField extends StatelessWidget {
  const CustomTextInputField({
    super.key,
    required this.onValueChnage,
    required this.hint,
    this.textInputType,
    this.onValidate,
    required this.decoration,
    this.controller,
  });

  final String hint;
  final Function(String) onValueChnage;
  final Function(String)? onValidate;
  final TextInputType? textInputType;
  final InputDecoration decoration;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        onValueChnage(value);
      },
      controller: controller,
      cursorColor: Colors.grey,
      keyboardType: textInputType,
      decoration: decoration.copyWith(hintText: hint),
    );
  }
}

class CustomPasswordInputField extends StatelessWidget {
  const CustomPasswordInputField({
    Key? key,
    required this.onValueChnage,
    required this.hint,
    required this.decoration,
    this.controller,
  }) : super(key: key);
  final String hint;
  final Function(String) onValueChnage;
  final InputDecoration decoration;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<UiServiceProvider>(
      builder: (context, uiProvider, _) {
        return TextField(
          onChanged: (value) {
            onValueChnage(value);
          },
          controller: controller,
          cursorColor: Colors.grey,
          obscureText: uiProvider.isObsecure,
          decoration: decoration.copyWith(
            hintText: hint,
            suffixIcon: IconButton(
              onPressed: () {
                uiProvider.obsecureText();
              },
              icon: const Icon(
                Icons.remove_red_eye,
                color: Color(0XFF606060),
              ),
            ),
          ),
        );
      },
    );
  }
}
