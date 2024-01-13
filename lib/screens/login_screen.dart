import 'package:billpayment/constants/styles/decoration.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/custom_widgets/custom_label.dart';
import 'package:billpayment/custom_widgets/input_field.dart';
import 'package:billpayment/routes/routes.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailOrPhoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          child: Container(
            decoration: appBackgroundDecoration,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 24, right: 24),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Label(label: "username/email"),
                        CustomTextInputField(
                          onValueChnage: (value) {},
                          hint: "Phone Number",
                          valueControler: emailOrPhoneNumber,
                          decoration: textFormFieldDecoration,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Label(label: "password"),
                        CustomPasswordInputField(
                            onValueChnage: (value) {},
                            hint: "password",
                            valueController: password,
                            decoration: passwordFormFieldDecoration),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 34,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RouteGenerator.forgotPassword);
                            },
                            child: const Text(
                              "Forgot Password",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 51, 70, 134),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          onPress: () => {print("login request send")},
                          horizontalMargin: 0,
                          verticalMargin: 0,
                          btnName: Consumer<UiServiceProvider>(
                              builder: (context, uiProvider, _) {
                            return uiProvider.isLoging
                                ? const CircularProgressIndicator()
                                : const Text("Login", style: textStyle);
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Expanded(
                              child: Text(""),
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  height: 1,
                                  color: Colors.white,
                                )),
                            const Expanded(
                                child: Text(
                              "    or",
                              style: TextStyle(color: Color(0XFF7F8E9D)),
                            )),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  height: 1,
                                  color: Colors.white,
                                )),
                            const Expanded(
                              child: Text(""),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/face.jpeg"))),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(""),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/google.png"))),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(""),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: const DecorationImage(
                                      image:
                                          AssetImage("assets/images/mac.png"))),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(""),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Color(0XFF1E3354),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RouteGenerator.signup_screen);
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Color(0XFF6286CB),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                      // isLoging
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
