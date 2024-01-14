import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomMenu extends StatelessWidget {
  const CustomBottomMenu(
      {super.key,
      required this.onClick,
      required this.icon,
      required this.menuName});

  final Function onClick;
  final IconData icon;
  final String menuName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          padding: const EdgeInsets.only(top: 10),
          constraints: const BoxConstraints(),
          onPressed: () => onClick,
          icon: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        Text(
          menuName,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(fontSize: 8, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
