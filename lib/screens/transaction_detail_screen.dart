import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key});
  final String billTitle = 'Electricity Bill';
  final double billAmount = 75.50;
  final String dueDate = '2024-01-31';
  final bool isPaid = false;
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
                    "Bill Details",
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
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Name: electric',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Amount: 7893',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Due Date: juldueDate 12 2033',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Status: pending',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: getStatusColor("Pending"),
                    ),
                  ),
                  // const Spacer(),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    onPress: () => {},
                    btnName: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.payment, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text(
                          'Pay Bill',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    horizontalMargin: 0,
                    verticalMargin: 0,
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

void _onActionButtonPressed() {
  // Implement logic for the action (e.g., navigate to payment screen)
  print('Action button pressed');
}

Color getStatusColor(String status) {
  switch (status) {
    case 'Paid':
      return Colors.green;
    case 'Pending':
      return Colors.orange;
    case 'Overdue':
      return Colors.red;
    default:
      return Colors.black;
  }
}
