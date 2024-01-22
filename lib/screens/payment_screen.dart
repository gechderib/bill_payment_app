import 'dart:ffi';
import 'dart:io';

import 'package:billpayment/authentication/auth_info.dart';
import 'package:billpayment/constants/styles/decoration.dart';
import 'package:billpayment/constants/variables/const.dart';
import 'package:billpayment/custom_widgets/bill_summary.dart';
import 'package:billpayment/custom_widgets/custom_button.dart';
import 'package:billpayment/custom_widgets/input_field.dart';
import 'package:billpayment/custom_widgets/loading_shimmer.dart';
import 'package:billpayment/models/bill.dart';
import 'package:billpayment/models/transaction.dart';
import 'package:billpayment/service/api_service.dart';
import 'package:billpayment/service/input_value_controller.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiServiceProvider>(context);
    final authInfo = Provider.of<AuthInfo>(context);
    final inputProvider = Provider.of<InputFieldControllerProvider>(context);
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder(
                  future: billProvider.getUserBills(userId),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Bill> myList = snapshot.data;
                      return DropdownButton<Bill>(
                        value: null,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 85, 85, 85),
                          fontSize: 18.0,
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Color.fromARGB(255, 134, 134, 134),
                          size: 30.0,
                        ),
                        iconSize: 24.0,
                        elevation: 16,
                        underline: Container(
                          height: 1,
                          color: const Color.fromARGB(255, 117, 117, 117),
                        ),
                        isExpanded: true,
                        onChanged: (selectedBill) {},
                        items: myList.map((Bill bill) {
                          return DropdownMenuItem<Bill>(
                            value: bill,
                            onTap: () {
                              uiProvider.setSelectedBill(bill);
                              inputProvider.setPaymentController(bill.amount);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(bill.name),
                                Text(
                                  bill.status,
                                  style: TextStyle(
                                    color: bill.status == "pending"
                                        ? getStatusColor("pending")
                                        : bill.status == "completed"
                                            ? getStatusColor("completed")
                                            : getStatusColor("overdue"),
                                  ),
                                ),
                                Text("ETB. ${bill.amount}")
                              ],
                            ),
                          );
                        }).toList(),
                        hint: const Text('Select a bill'),
                      );
                    }
                    return const LoadingCard();
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  cursorColor: Colors.grey,
                  controller: inputProvider.paymentController,
                  decoration: const InputDecoration(
                    labelText: 'Enter bill amount',
                    contentPadding: EdgeInsets.only(
                      left: 16,
                      top: 5,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(62, 62, 62, 1)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 0.7,
                          color: Color.fromRGBO(62, 62, 62, 1)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                horizontalMargin: 0,
                verticalMargin: 0,
                btnName: const Text(
                  "Pay Bill",
                  style: TextStyle(color: Colors.white),
                ),
                onPress: () async {
                  if (uiProvider.selectedBill?.status == "completed") {
                    await uiProvider.showToast(
                        "Already Paid", Colors.yellow, Colors.white);
                    return;
                  }
                  if (double.parse(inputProvider.paymentController.text) !=
                      uiProvider.selectedBill?.amount) {
                    await uiProvider.showToast(
                        "Enter Correct Amount: ${uiProvider.selectedBill?.amount}",
                        Colors.redAccent,
                        Colors.white);
                    return;
                  }
                  if (double.parse(inputProvider.paymentController.text) ==
                      uiProvider.selectedBill?.amount) {
                    var res = await billProvider.payBill(
                      "${uiProvider.selectedBill?.id}",
                      Transaction.fromJson({
                        "name": uiProvider.selectedBill?.name,
                        "amount": uiProvider.selectedBill?.amount,
                        "dueDate": uiProvider.selectedBill?.dueDate,
                        "status": "completed",
                        "userId": uiProvider.selectedBill?.userId,
                      }),
                    );
                    return;
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
