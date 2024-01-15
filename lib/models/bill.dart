class Bill {
  Bill(
      {required this.name,
      required this.amout,
      required this.dueDate,
      required this.status});

  String name;
  double amout;
  DateTime dueDate;
  bool status;

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
        name: json["name"],
        amout: json["amount"],
        dueDate: json["duedate"],
        status: json["status"]);
  }
}

  // factory ArticleModel.fromJson(Map<String, dynamic> json) {

