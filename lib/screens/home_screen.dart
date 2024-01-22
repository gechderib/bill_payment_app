import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/constants/variables/const.dart';
import 'package:billpayment/constants/styles/decoration.dart';
import 'package:billpayment/constants/variables/enums.dart';
import 'package:billpayment/custom_widgets/bill_summary.dart';
import 'package:billpayment/custom_widgets/custom_drawer.dart';
import 'package:billpayment/custom_widgets/input_field.dart';
import 'package:billpayment/custom_widgets/loading_shimmer.dart';
import 'package:billpayment/custom_widgets/payment_history_cards.dart';
import 'package:billpayment/custom_widgets/upcoming_bill.dart';
import 'package:billpayment/models/bill.dart';
import 'package:billpayment/models/transaction.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/input_value_controller.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiServiceProvider>(context, listen: false);
    final authInfo = Provider.of<AuthInfo>(context, listen: false);
    final billProvider = Provider.of<BillProvider>(context, listen: false);
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    return Scaffold(
      drawer: const BillPaymentDrawer(),
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
                        Scaffold.of(ctx).openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text(
                  "welcome ${authInfo.logedUserInfo["fullName"]}",
                  style: const TextStyle(
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
                Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      margin: const EdgeInsets.only(right: 13),
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
          Expanded(
            flex: 3,
            child: FutureBuilder(
              future: billProvider.getUserBills(authInfo.logedUserInfo["id"]),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  double totalOutStanding = 0;
                  int pendingBills = 0;
                  String DueDate = "";

                  for (var bill in snapshot.data) {
                    if (bill.status == "pending") {
                      pendingBills++;
                      totalOutStanding += bill.amount;
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
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "pending".tr() + " " + "bills".tr(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(221, 34, 34, 34),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: FutureBuilder(
              future: billProvider.getUserBills(authInfo.logedUserInfo["id"]),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<dynamic> pendingBills = snapshot.data
                      .where((userBill) => userBill.status == "pending")
                      .toList();
                  return ListView.builder(
                    itemCount: pendingBills.length,
                    itemBuilder: (context, index) {
                      return UpcomingBill(
                        onBillDetail: () {
                          uiProvider.detail_bill_id = pendingBills[index].id;
                          uiProvider.changeIndex(5);
                        },
                        onClick: () => {
                          _showPaymentDialog(
                            context,
                            Bill(
                                id: pendingBills[index].id,
                                name: pendingBills[index].name,
                                amount: pendingBills[index].amount,
                                dueDate: DateTime.now().toString(),
                                status: pendingBills[index].status,
                                userId: authInfo.logedUserInfo["id"]),
                          ),
                        },
                        billAmount: pendingBills[index].amount,
                        billName: pendingBills[index].name,
                        dueDate: pendingBills[index].dueDate,
                      );
                    },
                  );
                }
                return const LoadingShimmer();
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "payment".tr() + " " + "history".tr(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(221, 34, 34, 34),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: FutureBuilder(
              future: transactionProvider
                  .getAllTransactions(authInfo.logedUserInfo["id"]),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return PaymentHistoryListTile(
                        onClick: () {
                          uiProvider.detail_transaction_id =
                              snapshot.data[index]["id"];
                          uiProvider.changeIndex(6);
                        },
                        billAmount: snapshot.data[index]["amount"],
                        billName: snapshot.data[index]["name"],
                        dueDate: snapshot.data[index]["dueDate"],
                        status: snapshot.data[index]["status"] == "pending"
                            ? Icons.pending
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
    );
  }
}

void _showPaymentDialog(BuildContext context, Bill bill) {
  final inputFieldController =
      Provider.of<InputFieldControllerProvider>(context, listen: false);
  final uiProvider = Provider.of<UiServiceProvider>(context, listen: false);
  final billProvider = Provider.of<BillProvider>(context, listen: false);

  Map<String, dynamic> transactionJson = {
    "name": bill.name,
    "amount": bill.amount,
    "dueDate": bill.dueDate,
    "status": "completed",
    "userId": bill.userId,
  };

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Payment Confirmation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter the payment amount: ${bill.amount}'),
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
              if (bill.status == "completed") {
                await uiProvider.showToast(
                    "Already Paid", Colors.yellow, Colors.white);
                return;
              }
              if (inputFieldController.paymentAmount != bill.amount) {
                await uiProvider.showToast(
                    "Enter Correct Amount: ${bill.amount}",
                    Colors.redAccent,
                    Colors.white);
                return;
              }
              if (inputFieldController.paymentAmount == bill.amount) {
                var res = await billProvider.payBill(
                  "${bill.id}",
                  Transaction.fromJson(transactionJson),
                );
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
