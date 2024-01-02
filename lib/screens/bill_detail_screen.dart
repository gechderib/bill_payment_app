import 'package:flutter/material.dart';

class BillDetailScreen extends StatelessWidget {
  const BillDetailScreen({super.key});
  final String billTitle = 'Electricity Bill';
  final double billAmount = 75.50;
  final String dueDate = '2024-01-31';
  final bool isPaid = false;
  @override
  Widget build(BuildContext context) {
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
                Container()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bill Title: $billTitle',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Amount: \$${billAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Due Date: $dueDate',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Status: ${isPaid ? 'Paid' : 'Pending'}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isPaid ? Colors.green : Colors.red,
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _onActionButtonPressed();
                  },
                  child: Text(isPaid ? 'View Receipt' : 'Pay Bill'),
                ),
              ],
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
