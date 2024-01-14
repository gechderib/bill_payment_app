import 'package:billpayment/custom_widgets/bill_summary.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<PaymentScreenState>(context);
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
                        Navigator.of(context).pop();
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
                ),
                Container()
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: BillSummary(
                totalOutstanding: 859,
                pendingBilles: 21,
                dueDate: "july 12 2023"),
          ),
          SizedBox(
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
                    hint: Text('Select Bill'),
                    onChanged: (String? newValue) {
                      uiProvider.setBill(newValue!);
                    },

                    style: TextStyle(color: Colors.black), // Change text color
                    icon: Icon(Icons.arrow_drop_down_circle,
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
                                SizedBox(
                                  width: 120,
                                ),
                                Text("ETB. 747"),
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      uiProvider
                          .setPaymentAmount(double.tryParse(value) ?? 0.0);
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Amount',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  CustomButton(
                      horizontalMargin: 0,
                      verticalMargin: 10,
                      btnName: Text("Confirm Payment"),
                      onPress: () {
                        _confirmPayment(context);
                      }),
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
                  // Navigate to a success page or perform any other actions
                  // You can replace the next line with your navigation logic
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
