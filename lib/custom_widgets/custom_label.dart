import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Label extends StatelessWidget {
  const Label({Key? key, required this.label}) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      margin: const EdgeInsets.only(),
      child: Text(
        label,
        style: GoogleFonts.lato(
            textStyle: GoogleFonts.lato(
                textStyle: const TextStyle(color: Color(0xFF1E3354)))),
      ),
    );
  }
}
