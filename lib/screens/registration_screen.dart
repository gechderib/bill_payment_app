import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/constants/styles/decoration.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/custom_widgets/custom_label.dart';
import 'package:billpayment/custom_widgets/input_field.dart';
import 'package:billpayment/routes/routes.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});
  void _handelRegister(
      String fullName, String email, String phone, String password) {
    print('Phone Number: $phone');
    print('Password: $password');
    print('fullName: $fullName');
    print('email: $email');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authInfo = Provider.of<AuthInfo>(context);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: size.width,
        height: size.height,
        child: Container(
          decoration: appBackgroundDecoration,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Label(label: "Full Name"),
                    CustomTextInputField(
                      onValueChnage: (value) {
                        authInfo.fullName = value;
                      },
                      hint: "full name",
                      decoration: textFormFieldDecoration,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Label(label: "Email"),
                    CustomTextInputField(
                      onValueChnage: (value) {
                        authInfo.email = value;
                      },
                      hint: "email",
                      decoration: textFormFieldDecoration,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Label(label: "Email/Phone number"),
                    CustomTextInputField(
                      onValueChnage: (value) {
                        authInfo.phone = value;
                      },
                      hint: "email/phone",
                      decoration: textFormFieldDecoration,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Label(label: "Password"),
                    CustomPasswordInputField(
                        onValueChnage: (value) {
                          authInfo.password = value;
                        },
                        hint: "password",
                        decoration: passwordFormFieldDecoration),
                    const SizedBox(
                      height: 15,
                    ),
                    const Label(label: "Confirm Password"),
                    CustomPasswordInputField(
                        onValueChnage: (value) {
                          authInfo.password = value;
                        },
                        hint: "confirm password",
                        decoration: passwordFormFieldDecoration),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      onPress: () {
                        _handelRegister(authInfo.fullName, authInfo.email,
                            authInfo.phone, authInfo.password);
                      },
                      horizontalMargin: 0,
                      verticalMargin: 0,
                      btnName: Consumer<UiServiceProvider>(
                          builder: (context, uiProvider, _) {
                        return uiProvider.isLoging
                            ? const CircularProgressIndicator()
                            : const Text("Signup", style: textStyle);
                      }),
                    ),
                    Container(
                      height: 35,
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Already have an account?.",
                            style: TextStyle(
                                color: Color(0xFF1E3354), fontSize: 16),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RouteGenerator.loginScreen);
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                  ], // isLoging
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
