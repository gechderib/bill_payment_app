import 'package:billpayment/constants/const.dart';
import 'package:billpayment/custom_widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: BillPaymentDrawer(),
      body: Container(
        child: Column(
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
                          Scaffold.of(ctx).openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: const Text(
                      "Welcome Getachew",
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
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        margin: EdgeInsets.only(right: 13),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/prof.png"),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: size.height - (APP_BAR_HEIGHT + BOTTOM_SHEET_HEIGHT),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Text("Overview of bill summary ")),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Text("Overview of upcoming payment ")),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Text("Overview of payment history ")),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
