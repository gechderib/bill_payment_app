import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/constants/styles/decoration.dart';
import 'package:billpayment/routes/routes.dart';
import 'package:billpayment/screens/home_screen.dart';
import 'package:billpayment/screens/login_screen.dart';
import 'package:billpayment/screens/main_screen.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashScreenState = Provider.of<UiServiceProvider>(context);
    final authInfo = Provider.of<AuthInfo>(context);

    final size = MediaQuery.of(context).size;

    splashScreenState.loadContent(context);

    if (splashScreenState.isLoading) {
      authInfo.getLoginUser();
      return SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Container(
              height: size.height,
              width: size.width,
              decoration: appBackgroundDecoration,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/bill_logo.png",
                    height: 200,
                    width: 150,
                  ),
                  const Text(
                    "Your Bill Payment App",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      if (authInfo.logedUserInfo.isNotEmpty) {
        return SafeArea(child: MainScreen());
      } else {
        return SafeArea(child: LoginScreen());
      }
    }
  }
}
