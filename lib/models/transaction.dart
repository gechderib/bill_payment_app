class Transaction {
  Transaction({
    this.id,
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.status,
    required this.userId,
  });

  String? id;
  String name;
  double amount;
  String dueDate;
  String status;
  String userId;

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        dueDate: json["dueDate"],
        status: json["status"],
        userId: json["userId"]);
  }
}
