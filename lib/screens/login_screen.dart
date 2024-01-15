import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/constants/styles/decoration.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/custom_widgets/custom_label.dart';
import 'package:billpayment/custom_widgets/input_field.dart';
import 'package:billpayment/models/user.dart';
import 'package:billpayment/routes/routes.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authInfo = Provider.of<AuthInfo>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final uiProvider = Provider.of<UiServiceProvider>(context);

    var loginUserInfo = {
      "phone": authInfo.phone,
      "password": authInfo.password
    };
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Container(
          decoration: appBackgroundDecoration,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 24, right: 24, top: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Label(label: "Email/Phone number"),
                    CustomTextInputField(
                      onValueChnage: (value) {
                        authInfo.phone = value;
                      },
                      hint: "Email/Phone Number",
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
                      onPress: () async {
                        uiProvider.changeIsLoging(true);
                        var user = await authProvider
                            .loginUser(LoginModel.fromJson(loginUserInfo));
                        uiProvider.changeIsLoging(false);
                      },
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
                                  image:
                                      AssetImage("assets/images/face.jpeg"))),
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
                                      AssetImage("assets/images/google.png"))),
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
                                  image: AssetImage("assets/images/mac.png"))),
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
                            // Navigator.of(context)
                            //     .pushNamed(RouteGenerator.signupScreen);
                            Navigator.of(context)
                                .pushNamed(RouteGenerator.homeScreen);
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
