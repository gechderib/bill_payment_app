import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/constants/styles/decoration.dart';
import 'package:billpayment/custom_widgets/bill_summary.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/custom_widgets/input_field.dart';
import 'package:billpayment/custom_widgets/loading_shimmer.dart';
import 'package:billpayment/models/bill.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/input_value_controller.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiServiceProvider>(context);
    final authInfo = Provider.of<AuthInfo>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final billProvider = Provider.of<BillProvider>(context);

    final userId = authInfo.logedUserInfo["id"];
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
                  "payment",
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
                Container()
              ],
            ),
          ),
          Column(
            children: [
              Container(
                child: FutureBuilder(
                  future: billProvider.getUserBills(userId),
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
                child: FutureBuilder(
                  future: billProvider.getUserBills(userId),
                  builder: (context, AsyncSnapshot snapshot) {
                    // print(snapshot);
                    if (snapshot.hasData) {
                      List<Bill> myList = snapshot.data;
                      return DropdownButton<Bill>(
                        value: null,
                        onChanged: (selectedBill) {},
                        items: myList.map((Bill bill) {
                          return DropdownMenuItem<Bill>(
                            value: bill,
                            onTap: () {
                              uiProvider.setSelectedBill(bill);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(bill.name),
                                Text(bill.status),
                                Text("${bill.amount}")
                              ],
                            ),
                          );
                        }).toList(),
                        hint: Text('Select a bill'),
                      );
                    }
                    return const LoadingCard();
                  },
                ),
              ),
              CustomTextInputField(
                onValueChnage: (value) {},
                hint: "amount",
                decoration: textFormFieldDecoration,
              ),
              CustomButton(
                horizontalMargin: 0,
                verticalMargin: 0,
                btnName: Text("Pay Bill"),
                onPress: () {},
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.download),
      ),
    );
  }
}
