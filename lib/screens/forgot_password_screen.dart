import 'package:billpayment/constants/styles/decoration.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/custom_widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: appBackgroundDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: const Text(
                  'Enter your phone number to reset your password.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomTextInputField(
                  onValueChnage: (value) {},
                  hint: "Phone number",
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                      left: 16,
                      top: 5,
                    ),
                    labelText: "Phone number",
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(62, 62, 62, 1)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 0.7,
                          color: Color.fromRGBO(62, 62, 62, 1)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    hintStyle: GoogleFonts.lato(
                        textStyle: const TextStyle(fontSize: 13)),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              CustomButton(
                horizontalMargin: 0,
                verticalMargin: 0,
                btnName: const Text(
                  "Reset Password",
                  style: TextStyle(color: Colors.white),
                ),
                onPress: () {
                  _sendPasswordResetEmail();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendPasswordResetEmail() {
    String phone = phoneNumberController.text;

    print('Password reset phone sent to: $phone');
  }
}
