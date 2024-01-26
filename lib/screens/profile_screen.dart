import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/screens/login_screen.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiServiceProvider>(context);
    final authInfo = Provider.of<AuthInfo>(context);
    final authProvider = Provider.of<AuthProvider>(context);

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
                const Text(
                  "User Profile",
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
                Container(
                  margin: const EdgeInsets.only(left: 40),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Container(
                    height: 200,
                    margin: const EdgeInsets.only(right: 13),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/pro.jpg"),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  ListTile(
                    title: const Text('Full Name'),
                    subtitle: Text("${authInfo.logedUserInfo["fullName"]}"),
                  ),
                  ListTile(
                    title: const Text('Email'),
                    subtitle: Text("${authInfo.logedUserInfo["email"]}"),
                  ),
                  ListTile(
                    title: const Text('Current Password'),
                    subtitle: TextField(
                      controller: currentPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Current Password',
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('New Password'),
                    subtitle: TextField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'New Password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  CustomButton(
                    horizontalMargin: 0,
                    verticalMargin: 0,
                    btnName: uiProvider.isLoging
                        ? const CircularProgressIndicator()
                        : const Text(
                            "Change Password",
                            style: TextStyle(color: Colors.white),
                          ),
                    onPress: () async {
                      uiProvider.changeIsLoging(true);
                      if (currentPasswordController.text ==
                          authInfo.logedUserInfo["password"]) {
                        await authProvider.changePassword(
                            authInfo.logedUserInfo["id"],
                            newPasswordController.text);
                        await authInfo.logedOutUser();
                        uiProvider.changeIsLoging(false);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      } else {
                        await uiProvider.showToast(
                          "Incorrect Password",
                          Colors.redAccent,
                          Colors.white,
                        );
                        uiProvider.changeIsLoging(false);
                      }
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
