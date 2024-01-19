import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/constants/const.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/routes/routes.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String language = 'English';
  String selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiServiceProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 56,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  margin: const EdgeInsets.only(left: 12),
                  child: Builder(
                    builder: (ctx) => IconButton(
                      onPressed: () {
                        uiProvider.changeIndex(uiProvider.prevActiveIndex);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: const Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Mulish",
                      shadows: [
                        Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Language'),
                    subtitle: DropdownButton<String>(
                      value: language,
                      onChanged: (newValue) {
                        setState(() {
                          language = newValue!;
                        });
                      },
                      items: LANGUAGES
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  const Text(
                    'App Settings',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    title: const Text('Theme'),
                    subtitle: DropdownButton<String>(
                      value: selectedTheme,
                      onChanged: (newValue) {
                        setState(() {
                          selectedTheme = newValue!;
                        });
                      },
                      items: THEME
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  CustomButton(
                    horizontalMargin: 70,
                    verticalMargin: 0,
                    btnName: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPress: () => {
                      _showLogoutConfirmationDialog(context),
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showLogoutConfirmationDialog(BuildContext context) {
  final authInfo = Provider.of<AuthInfo>(context, listen: false);
  final uiProvider = Provider.of<UiServiceProvider>(context, listen: false);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout Confirmation'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              authInfo.logedOutUser();
              Navigator.of(context).pushNamed(RouteGenerator.loginScreen);
              uiProvider.showToast(
                  "Successfully loged out", Colors.green, Colors.white);
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
