import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/custom_widgets/bill_summary.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/custom_widgets/loading_shimmer.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<PaymentScreenState>(context);
    final billProvider = Provider.of<BillProvider>(context, listen: false);
    final authInfo = Provider.of<AuthInfo>(context);

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
                  DropdownButton<String>(
                    value: uiProvider.selectedBill,
                    hint: const Text('Select Bill'),
                    onChanged: (String? newValue) {
                      uiProvider.setBill(newValue!);
                    },
                    style: const TextStyle(
                        color: Colors.black), // Change text color
                    icon: const Icon(Icons.arrow_drop_down_circle,
                        color: Colors.black38), // Change dropdown icon color
                    items: uiProvider.bills.map<DropdownMenuItem<String>>(
                      (String value) {
                        print(value);
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(value),
                                const SizedBox(
                                  width: 120,
                                ),
                                const Text("ETB. 747"),
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      uiProvider
                          .setPaymentAmount(double.tryParse(value) ?? 0.0);
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
                    onPress: () {
                      _confirmPayment(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmPayment(BuildContext context) async {
    bool paymentSuccess = true; // Set to false for a failure scenario

    String resultMessage =
        paymentSuccess ? 'Payment Successful!' : 'Payment Failed. Try again.';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Result'),
          content: Text(resultMessage),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (paymentSuccess) {
                  Navigator.of(context).pop();
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
