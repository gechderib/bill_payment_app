import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BillSummary extends StatelessWidget {
  const BillSummary(
      {super.key,
      required this.totalOutstanding,
      required this.pendingBilles,
      required this.dueDate});

  final double totalOutstanding;
  final int pendingBilles;
  final String dueDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Colors.blue,
            Color.fromARGB(255, 198, 76, 209),
            Colors.green
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "total".tr() + " " + "outstanding".tr() + " " + "amount".tr(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "ETB. $totalOutstanding",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "pending".tr() + " " + "bills".tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "$pendingBilles",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "due_date".tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    dueDate,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
