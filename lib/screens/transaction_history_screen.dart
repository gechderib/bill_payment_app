import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/custom_widgets/loading_shimmer.dart';
import 'package:billpayment/custom_widgets/payment_history_cards.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
    final uiProvider = Provider.of<UiServiceProvider>(context);
    final authInfo = Provider.of<AuthInfo>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);
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
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: const TextField(
              style: TextStyle(fontSize: 16.0),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: transactionProvider
                  .getAllTransactions(authInfo.logedUserInfo["id"]),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final transaction = snapshot.data[index];
                      return PaymentHistoryListTile(
                        billAmount: transaction["amount"],
                        billName: transaction["name"],
                        dueDate: transaction["dueDate"],
                        onClick: () {
                          uiProvider.detail_transaction_id = transaction["id"];
                          uiProvider.changeIndex(6);
                        },
                        status: transaction["status"] == "pending"
                            ? Icons.pending_actions
                            : Icons.check,
                      );
                    },
                  );
                }
                return LoadingShimmer();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
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
