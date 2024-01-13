import 'package:billpayment/screens/login_screen.dart';
import 'package:billpayment/screens/registration_screen.dart';
import 'package:billpayment/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String splash_screen = "/";
  static const String login_screen = "/login";
  static const String signup_screen = "/signup";
  static const String forgotPassword = "/login";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash_screen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case login_screen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signup_screen:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Text("Route not fount"),
        );
    }
  }
}
