import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/constants/styles/decoration.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/custom_widgets/custom_label.dart';
import 'package:billpayment/custom_widgets/input_field.dart';
import 'package:billpayment/models/user.dart';
import 'package:billpayment/routes/routes.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authInfo = Provider.of<AuthInfo>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final uiProvider = Provider.of<UiServiceProvider>(context, listen: false);

    var registrationInfo = {
      "fullName": authInfo.fullName,
      "email": authInfo.email,
      "phone": authInfo.phone,
      "password": authInfo.password
    };

    void handelRegister() async {
      try {
        uiProvider.changeIsLoging(true);
        final user = await authProvider.createUser(
          UserModel.fromJson(registrationInfo),
        );

        if (user != null) {
          Navigator.of(context).pushNamed(RouteGenerator.loginScreen);
        } else {
          print('User creation failed.');
        }
      } catch (error) {
        print('Error during user creation: $error');
      } finally {
        uiProvider.changeIsLoging(false);
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: size.width,
          height: size.height,
          child: Container(
            // decoration: appBackgroundDecoration,
            padding: const EdgeInsets.only(top: 40),
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
                        hint: "Enter full name",
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
                        hint: "Enter email address",
                        decoration: textFormFieldDecoration,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Label(label: "Phone number"),
                      CustomTextInputField(
                        onValueChnage: (value) {
                          authInfo.phone = value;
                        },
                        hint: "Enter phone",
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
                          hint: "Enter password",
                          decoration: passwordFormFieldDecoration),
                      const SizedBox(
                        height: 15,
                      ),
                      const Label(label: "Confirm Password"),
                      CustomPasswordInputField(
                          onValueChnage: (value) {
                            authInfo.password = value;
                          },
                          hint: "Confirm password",
                          decoration: passwordFormFieldDecoration),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        onPress: () => handelRegister(),
                        horizontalMargin: 0,
                        verticalMargin: 0,
                        btnName: Consumer<UiServiceProvider>(
                          builder: (context, uiProvider, _) {
                            return uiProvider.isLoging
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text("signup".tr(), style: textStyle);
                          },
                        ),
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
                              child: Text(
                                "login".tr(),
                                style: TextStyle(
                                    fontSize: 16, color: Color(0XFF6286CB)),
                              ),
                            )
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
      ),
    );
  }
}
