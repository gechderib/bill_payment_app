import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/authentication/auth_service.dart';
import 'package:billpayment/constants/styles/decoration.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/custom_widgets/input_field.dart';
import 'package:billpayment/routes/routes.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseProvider = Provider.of<FirebaseAuthProvider>(context);
    final authInfo = Provider.of<AuthInfo>(context);
    final uiProvider = Provider.of<UiServiceProvider>(context);

    return Scaffold(
      body: Container(
        decoration: appBackgroundDecoration,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextInputField(
                      onValueChnage: (smsCode) {
                        firebaseProvider.smsCode = smsCode;
                      },
                      hint: "Verification code",
                      decoration: textFormFieldDecoration),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  horizontalMargin: 0,
                  verticalMargin: 0,
                  btnName: const Text(
                    "Verify",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPress: () async {
                    try {
                      await firebaseProvider.verifySms();
                      await authInfo.addloginUserInfo(authInfo.user);
                      await authInfo.getLoginUser();
                      Navigator.of(context)
                          .pushNamed(RouteGenerator.homeScreen);
                    } catch (e) {
                      await uiProvider.showToast("Verification not completed",
                          Colors.redAccent, Colors.white);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
