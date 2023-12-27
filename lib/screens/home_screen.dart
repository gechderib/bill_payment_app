import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: Container(
          alignment: Alignment.center,
          child: IconButton(
              alignment: Alignment.center,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Color.fromARGB(255, 65, 21, 168),
              )),
        ),
        backgroundColor: const Color.fromARGB(255, 80, 97, 255),
        automaticallyImplyLeading: false,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 22,
              color: Color(0xFF1E3354),
              fontWeight: FontWeight.w300),
        ),
      ),
      body: const Text("home screen"),
    );
  }
}
