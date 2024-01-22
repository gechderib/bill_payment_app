import 'dart:io';

import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/custom_widgets/loading_shimmer.dart';
import 'package:billpayment/custom_widgets/payment_history_cards.dart';
import 'package:billpayment/models/transaction.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TransactionHistoryScreen extends StatelessWidget {
  TransactionHistoryScreen({super.key});
  List<dynamic> transactions = [];
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiServiceProvider>(context);
    final authInfo = Provider.of<AuthInfo>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);

    TextEditingController searchController = TextEditingController();

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
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                uiProvider.filterTransactions(value, transactions);
              },
              style: const TextStyle(fontSize: 16.0),
              decoration: const InputDecoration(
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
                  if (searchController.text.isNotEmpty) {
                    transactions = uiProvider.filteredTransactions;
                  } else {
                    transactions = snapshot.data;
                  }
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
                return const LoadingShimmer();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            _downloadStatements(context, transactions);
          },
          child: const Icon(Icons.download),
        ),
      ),
    );
  }
}

void _showFilterOptions() {
  print('Show filter options');
}

void _downloadStatements(
    BuildContext context, List<dynamic> transactions) async {
  List<List<dynamic>> csvData = [
    ['Name', 'Amount', 'Due Date', 'Status', 'User ID']
  ];

  for (dynamic transaction in transactions) {
    csvData.add([
      transaction["name"],
      transaction["amount"],
      transaction["dueDate"],
      transaction["status"],
      transaction["userId"],
    ]);
  }

  String csvString = const ListToCsvConverter().convert(csvData);

  final Directory directory = await getExternalStorageDirectory() as Directory;
  final File file = File('${directory.path}/${DateTime.now().toString()}.csv');
  print(file);
  await file.writeAsString(csvString);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('CSV file downloaded successfully!'),
    ),
  );
}
