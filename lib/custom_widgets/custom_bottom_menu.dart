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
    return GestureDetector(
      onTap: () => {onClick()},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            menuName,
            style: GoogleFonts.lato(
              textStyle: const TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
