class Bill {
  Bill({
    required this.name,
    required this.amout,
    required this.dueDate,
    required this.status,
    required this.userId,
  });

  String name;
  double amout;
  DateTime dueDate;
  bool status;
  String userId;

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      name: json["name"],
      amout: json["amount"],
      dueDate: json["duedate"],
      status: json["status"],
      userId: json["status"],
    );
  }
}
