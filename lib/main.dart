import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/routes/routes.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/input_value_controller.dart';
import 'package:billpayment/service/theme_service.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
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
          ChangeNotifierProvider(create: (context) => ThemeProvider())
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
