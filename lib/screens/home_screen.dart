import 'package:billpayment/constants/const.dart';
import 'package:billpayment/custom_widgets/bill_summary.dart';
import 'package:billpayment/custom_widgets/custom_drawer.dart';
import 'package:billpayment/custom_widgets/payment_history_cards.dart';
import 'package:billpayment/custom_widgets/upcoming_bill.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final uiProvider = Provider.of<UiServiceProvider>(context);

    return Scaffold(
      drawer: const BillPaymentDrawer(),
      body: Container(
        child: Column(
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
                    child: const Text(
                      "Welcome Getachew",
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
            Container(
              height: size.height - (APP_BAR_HEIGHT + BOTTOM_SHEET_HEIGHT),
              child: Column(
                children: [
                  const Expanded(
                    flex: 3,
                    child: BillSummary(
                      totalOutstanding: 58588,
                      pendingBilles: 231,
                      dueDate: "14 Sept 2024",
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 10),
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
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return UpcomingBill(
                          onClick: () => {
                            _showPaymentDialog(context),
                          },
                          billAmount: 3000,
                          billName: "Electric",
                          dueDate: "Sept 13 2024",
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 20),
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
                    child: ListView.builder(
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return PaymentHistoryListTile(
                          onClick: () => {uiProvider.changeIndex(5)},
                          billAmount: 3000,
                          billName: "Electric",
                          dueDate: "Sept 13 2024",
                          status: Icons.check,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _showPaymentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Payment Confirmation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter the payment amount:'),
            const SizedBox(height: 10),
            TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                print(value);
              },
              decoration: const InputDecoration(
                prefixText: '\ETB ',
                hintText: 'Enter amount',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Perform payment action
              _makePayment(context, 453);
            },
            child: const Text('Confirm Payment'),
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
