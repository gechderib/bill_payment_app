class Transaction {
  Transaction(
      {required this.name,
      required this.amout,
      required this.dueDate,
      required this.status});

  String name;
  double amout;
  DateTime dueDate;
  bool status;

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        name: json["name"],
        amout: json["amount"],
        dueDate: json["duedate"],
        status: json["status"]);
  }
}
