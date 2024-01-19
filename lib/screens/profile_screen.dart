import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullName = 'Getachew Derib';
  String email = 'gechderib1221@gmail.com';
  String language = 'English';

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
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
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
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
                    margin: EdgeInsets.only(right: 13),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/pro.jpg"),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  ListTile(
                    title: Text('Full Name'),
                    subtitle: Text(fullName),
                  ),
                  ListTile(
                    title: Text('Email'),
                    subtitle: Text(email),
                  ),
                  ListTile(
                    title: Text('Current Password'),
                    subtitle: TextField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Current Password',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('New Password'),
                    subtitle: TextField(
                      controller: currentPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'New Password',
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  CustomButton(
                      horizontalMargin: 0,
                      verticalMargin: 0,
                      btnName: Text(
                        "Change Password",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPress: () => {})
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
