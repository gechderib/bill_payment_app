import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/constants/styles/decoration.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/custom_widgets/custom_label.dart';
import 'package:billpayment/custom_widgets/input_field.dart';
import 'package:billpayment/screens/login_screen.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiServiceProvider>(context);
    final authInfo = Provider.of<AuthInfo>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: appBackgroundDecoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Label(label: "New Password"),
                CustomPasswordInputField(
                  onValueChnage: (value) {},
                  controller: newPasswordController,
                  hint: "enter new password",
                  decoration: textFormFieldDecoration,
                ),
                const Label(label: "Confirm Password"),
                CustomPasswordInputField(
                  onValueChnage: (value) {},
                  controller: confirmPasswordController,
                  hint: "confirm password",
                  decoration: textFormFieldDecoration,
                ),
                const SizedBox(height: 20.0),
                CustomButton(
                  horizontalMargin: 0,
                  verticalMargin: 0,
                  btnName: uiProvider.isLoging
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Change Password",
                          style: TextStyle(color: Colors.white),
                        ),
                  onPress: () async {
                    uiProvider.changeIsLoging(true);
                    if (newPasswordController.text ==
                            confirmPasswordController.text &&
                        (newPasswordController.text != "")) {
                      final res = await authProvider.forgotPasswordUpdate(
                          uiProvider.forgotPasswordPhone,
                          newPasswordController.text);
                      uiProvider.changeIsLoging(false);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    } else {
                      await uiProvider.showToast("Please Confirm your password",
                          Colors.redAccent, Colors.white);
                      uiProvider.changeIsLoging(false);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
