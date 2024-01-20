import 'package:flutter/material.dart';

class UpcomingBill extends StatelessWidget {
  const UpcomingBill(
      {super.key,
      required this.onClick,
      required this.onBillDetail,
      required this.billAmount,
      required this.billName,
      required this.dueDate});
  final Function onClick;
  final Function onBillDetail;
  final String billName;
  final double billAmount;
  final String dueDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color.fromARGB(255, 230, 232, 233),
                Color.fromARGB(255, 230, 232, 233)
              ],
            ),
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(20),
              bottomEnd: Radius.circular(20),
            ),
          ),
          child: ListTile(
            onTap: () => onBillDetail(),
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
              onPressed: () {
                onClick();
              },
              child: const Text(
                "Pay",
                style: TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
