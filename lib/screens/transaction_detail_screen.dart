import 'package:billpayment/constants/styles/decoration.dart';
import 'package:billpayment/constants/variables/const.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/custom_widgets/input_field.dart';
import 'package:billpayment/custom_widgets/loading_shimmer.dart';
import 'package:billpayment/models/transaction.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/input_value_controller.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiServiceProvider>(context);
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);

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
            child: FutureBuilder(
              future: transactionProvider
                  .getOneTransaction(uiProvider.detail_transaction_id),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Name: ${snapshot.data["name"]}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Amount: ${snapshot.data["amount"]}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Due Date: ${snapshot.data["dueDate"]}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Status: ${snapshot.data["status"]}',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: snapshot.data["status"] == "pending"
                                  ? getStatusColor("pending")
                                  : snapshot.data["status"] == "completed"
                                      ? getStatusColor("completed")
                                      : getStatusColor("overdue")),
                        ),
                        // const Spacer(),
                        const SizedBox(
                          height: 50,
                        ),
                        snapshot.data["status"] == "pending" ||
                                snapshot.data["status"] == "overdue"
                            ? CustomButton(
                                onPress: () {
                                  _showPaymentDialog(
                                    context,
                                    Transaction(
                                      id: snapshot.data["id"],
                                      name: snapshot.data["name"],
                                      amount: snapshot.data["amount"],
                                      dueDate: snapshot.data["dueDate"],
                                      status: snapshot.data["status"],
                                      userId: snapshot.data["userId"],
                                    ),
                                  );
                                },
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
                              )
                            : Container(),
                      ],
                    ),
                  );
                }
                return const LoadingShimmer();
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _showPaymentDialog(BuildContext context, Transaction transaction) {
  final inputFieldController =
      Provider.of<InputFieldControllerProvider>(context, listen: false);
  final uiProvider = Provider.of<UiServiceProvider>(context, listen: false);
  final billProvider = Provider.of<BillProvider>(context, listen: false);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Payment Confirmation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter the payment amount: ${transaction.amount}'),
            const SizedBox(height: 10),
            CustomTextInputField(
                textInputType: TextInputType.number,
                onValueChnage: (value) {
                  inputFieldController.setPaymenAmount(double.parse(value));
                },
                hint: "Enter amount",
                decoration: textFormFieldDecoration),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (transaction.status == "completed") {
                await uiProvider.showToast(
                    "Already Paid", Colors.yellow, Colors.white);
                return;
              }
              if (inputFieldController.paymentAmount != transaction.amount) {
                await uiProvider.showToast(
                    "Enter Correct Amount: ${transaction.amount}",
                    Colors.redAccent,
                    Colors.white);
                return;
              }
              if (inputFieldController.paymentAmount == transaction.amount) {
                var res = await billProvider
                    .completPendingTransactions("${transaction.id}");
                Navigator.of(context).pop();
                return;
              }
            },
            child: const Text(
              'Confirm Payment',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
