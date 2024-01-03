import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: context.read<PaymentScreenState>().selectedBill,
              hint: Text('Select Bill'),
              onChanged: (String? newValue) {
                context.read<PaymentScreenState>().setBill(newValue!);
              },
              items: context
                  .read<PaymentScreenState>()
                  .bills
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                context
                    .read<PaymentScreenState>()
                    .setPaymentAmount(double.tryParse(value) ?? 0.0);
              },
              decoration: InputDecoration(
                labelText: 'Enter Amount',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _confirmPayment(context);
              },
              child: Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmPayment(BuildContext context) async {
    bool paymentSuccess = true; // Set to false for a failure scenario

    String resultMessage =
        paymentSuccess ? 'Payment Successful!' : 'Payment Failed. Try again.';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Result'),
          content: Text(resultMessage),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (paymentSuccess) {
                  // Navigate to a success page or perform any other actions
                  // You can replace the next line with your navigation logic
                  Navigator.of(context).pop();
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class PaymentScreenState extends ChangeNotifier {
  String selectedBill = '';
  double paymentAmount = 0.0;

  List<String> bills = ['Electricity Bill', 'Water Bill', 'Internet Bill'];

  void setBill(String bill) {
    selectedBill = bill;
    notifyListeners();
  }

  void setPaymentAmount(double amount) {
    paymentAmount = amount;
    notifyListeners();
  }
}
