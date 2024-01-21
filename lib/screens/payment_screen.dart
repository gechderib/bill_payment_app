import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/custom_widgets/bill_summary.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/custom_widgets/loading_shimmer.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/input_value_controller.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiServiceProvider>(context, listen: false);
    final billProvider = Provider.of<BillProvider>(context, listen: false);
    final authInfo = Provider.of<AuthInfo>(context, listen: false);
    final inputAmount =
        Provider.of<InputFieldControllerProvider>(context, listen: false);

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
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Payment",
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
            child: FutureBuilder(
              future: billProvider.getUserBills(authInfo.logedUserInfo["id"]),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  double totalOutStanding = 0;
                  int pendingBills = 0;
                  String dueDate = "";

                  for (var bill in snapshot.data) {
                    if (bill["status"] == "pending") {
                      pendingBills++;
                      totalOutStanding += bill["amount"];
                    }
                  }
                  return BillSummary(
                    totalOutstanding: totalOutStanding,
                    pendingBilles: pendingBills,
                    dueDate: "14 Sept 2024",
                  );
                }
                return const LoadingCard();
              },
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future: billProvider
                          .getUserBills(authInfo.logedUserInfo["id"]),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Text("data");
                        }
                        return const LoadingShimmer();
                      }),
                  const SizedBox(height: 20.0),
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      inputAmount
                          .setPaymenAmount(double.tryParse(value) ?? 0.0);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Amount',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  CustomButton(
                    horizontalMargin: 0,
                    verticalMargin: 10,
                    btnName: const Text(
                      "Confirm Payment",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPress: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
