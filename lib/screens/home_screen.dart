import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/constants/variables/const.dart';
import 'package:billpayment/constants/styles/decoration.dart';
import 'package:billpayment/constants/variables/enums.dart';
import 'package:billpayment/custom_widgets/bill_summary.dart';
import 'package:billpayment/custom_widgets/custom_drawer.dart';
import 'package:billpayment/custom_widgets/input_field.dart';
import 'package:billpayment/custom_widgets/payment_history_cards.dart';
import 'package:billpayment/custom_widgets/upcoming_bill.dart';
import 'package:billpayment/models/bill.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiServiceProvider>(context, listen: false);
    final authInfo = Provider.of<AuthInfo>(context, listen: false);
    final billProvider = Provider.of<BillProvider>(context, listen: false);
    final transactionProvider = Provider.of<TransactionProvider>(context);
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
                Container(
                  child: Text(
                    "Welcome ${authInfo.logedUserInfo["fullName"]}"
                        .substring(0, 15),
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
                ),
                Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      margin: EdgeInsets.only(right: 13),
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
                  future: billProvider.getUserBills(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      // var userData = snapshot.data.
                      return Text("hello man");
                    }
                    return Text("data");
                  })

              // BillSummary(
              //   totalOutstanding: 58588,
              //   pendingBilles: 231,
              //   dueDate: "14 Sept 2024",
              // ),
              ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pending Bills",
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(221, 34, 34, 34),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: FutureBuilder(
                  future: billProvider.getUserBills(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return UpcomingBill(
                            onClick: () => {
                              _showPaymentDialog(
                                context,
                                Bill(
                                    id: snapshot.data[index]["id"],
                                    name: snapshot.data[index]["name"],
                                    amount: snapshot.data[index]["amount"],
                                    dueDate: DateTime.now(),
                                    status: BillStatus.pending,
                                    userId: authInfo.logedUserInfo["id"]),
                              ),
                            },
                            billAmount: snapshot.data[index]["amount"],
                            billName: snapshot.data[index]["name"],
                            dueDate: snapshot.data[index]["dueDate"],
                          );
                        },
                      );
                    }
                    return Text("loasing data");
                  })),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 5),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Payment History",
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(221, 34, 34, 34),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: FutureBuilder(
              future: transactionProvider.getAllTransactions(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return PaymentHistoryListTile(
                        onClick: () => {uiProvider.changeIndex(5)},
                        billAmount: snapshot.data[index]["amount"],
                        billName: snapshot.data[index]["name"],
                        dueDate: snapshot.data[index]["dueDate"],
                        status:
                            snapshot.data[index]["status"] == BillStatus.pending
                                ? Icons.pending
                                : Icons.check,
                      );
                    },
                  );
                }
                return Text("loading");
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _showPaymentDialog(BuildContext context, Bill bill) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Payment Confirmation ${bill.status}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter the payment amount: ${bill.amount}'),
            const SizedBox(height: 10),
            CustomTextInputField(
                onValueChnage: (value) {},
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
            onPressed: () {
              _makePayment(context, 453);
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

void _makePayment(BuildContext context, double amount) {
  // Perform payment actions here
  print('Payment confirmed for \$ $amount');
  // You can add logic to process the payment, update the UI, etc.
  Navigator.of(context).pop(); // Close the dialog
}
