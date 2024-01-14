import 'package:flutter/material.dart';

class UpcomingBill extends StatelessWidget {
  const UpcomingBill(
      {super.key,
      required this.onClick,
      required this.billAmount,
      required this.billName,
      required this.dueDate});
  final Function onClick;
  final String billName;
  final double billAmount;
  final String dueDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Container(
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 1),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromARGB(255, 225, 228, 230),
                  Color.fromARGB(255, 230, 232, 233)
                ],
              ),
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(20),
                bottomEnd: Radius.circular(20),
              ),
            ),
            child: ListTile(
              onTap: () => onClick(),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              leading: Text(
                billName,
              ),
              title: Text(
                "ETB. $billAmount",
              ),
              subtitle: Text(
                dueDate,
              ),
              trailing: ElevatedButton(
                onPressed: () => {onClick()},
                child: const Text(
                  "Pay",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}