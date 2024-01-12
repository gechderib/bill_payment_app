import 'package:billpayment/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String splash_screen = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash_screen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
