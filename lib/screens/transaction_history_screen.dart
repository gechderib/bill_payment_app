import 'package:billpayment/custom_widgets/payment_history_cards.dart';
import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatelessWidget {
  TransactionHistoryScreen({super.key});
  final List<String> transactions = [
    'Transaction 1 - \$100.00',
    'Transaction 2 - \$50.00',
    'Transaction 3 - \$75.00',
    'Transaction 3 - \$75.00',
    'Transaction 3 - \$75.00',
    'Transaction 3 - \$75.00',
    'Transaction 3 - \$75.00',
    'Transaction 3 - \$75.00',
    'Transaction 1 - \$100.00',
    'Transaction 2 - \$50.00',
    'Transaction 3 - \$75.00',
    'Transaction 3 - \$75.00',
    'Transaction 3 - \$75.00',
    'Transaction 3 - \$75.00',
    'Transaction 3 - \$75.00',
    'Transaction 3 - \$75.00',
    // Add more transactions as needed
  ];
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
                const Text(
                  "Transaction History",
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
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    _showFilterOptions();
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                print(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search Transactions',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return PaymentHistoryListTile(
                  billAmount: 455,
                  billName: transaction,
                  dueDate: "May 23 2023",
                  onClick: () => {},
                  status: Icons.check,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _downloadStatements();
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}

void _showFilterOptions() {
  // Implement filter options UI or navigation here
  // You can use showModalBottomSheet or a new screen for filter options
  print('Show filter options');
}

void _downloadStatements() {
  // Implement download statements action
  print('Download statements');
}
