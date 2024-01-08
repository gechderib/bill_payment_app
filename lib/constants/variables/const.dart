import 'package:flutter/material.dart';

const double APP_BAR_HEIGHT = 56;
const double BOTTOM_SHEET_HEIGHT = 70;
const List<String> LANGUAGES = ['en', 'am'];
const List<String> THEME = ['Light', 'Dark'];
const String BASE_URL = "http://192.168.0.22:3000";

Color getStatusColor(String status) {
  switch (status) {
    case 'completed':
      return Colors.green;
    case 'pending':
      return Colors.orange;
    case 'overdue':
      return Colors.red;
    default:
      return Colors.black;
  }
}
