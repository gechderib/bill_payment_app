import 'dart:io';

import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/authentication/auth_service.dart';
import 'package:billpayment/routes/routes.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/input_value_controller.dart';
import 'package:billpayment/service/theme_service.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// this is a comment to check if !!...
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyDo__q8lSVqMh69pIIay13Tl1guZS2uW6M",
              appId: "1:953460582169:android:e4aca213d00e9524380788",
              messagingSenderId: "953460582169",
              projectId: "mini-bill-app"))
      : await Firebase.initializeApp();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale("en"), Locale("am")],
      path: "assets/translations",
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UiServiceProvider()),
          ChangeNotifierProvider(create: (context) => AuthInfo()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => BillProvider()),
          ChangeNotifierProvider(create: (context) => TransactionProvider()),
          ChangeNotifierProvider(
              create: (context) => InputFieldControllerProvider()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => FirebaseAuthProvider()),
        ],
        child: const BillPaymentApp(),
      ),
    ),
  );
}

class BillPaymentApp extends StatelessWidget {
  const BillPaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment App',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteGenerator.splashScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.dark,
      ),
      themeMode: context.watch<ThemeProvider>().theme == "Dark"
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}
