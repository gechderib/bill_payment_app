import 'package:billpayment/screens/forgot_password_screen.dart';
import 'package:billpayment/screens/login_screen.dart';
import 'package:billpayment/screens/main_screen.dart';
import 'package:billpayment/screens/registration_screen.dart';
import 'package:billpayment/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String splashScreen = "/";
  static const String loginScreen = "/login";
  static const String signupScreen = "/signup";
  static const String homeScreen = "/home";
  static const String forgotPassword = "/forgot_password";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signupScreen:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => MainScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Text("Route not fount"),
        );
    }
  }
}
