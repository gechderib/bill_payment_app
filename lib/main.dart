import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/routes/routes.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UiServiceProvider()),
      ChangeNotifierProvider(create: (context) => AuthInfo())
    ],
    child: const BillPaymentApp(),
  ));
}

class BillPaymentApp extends StatelessWidget {
  const BillPaymentApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment App',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteGenerator.splashScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
