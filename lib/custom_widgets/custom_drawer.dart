import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BillPaymentDrawer extends StatelessWidget {
  const BillPaymentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Colors.blueAccent,
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.blue, Colors.green],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    FontAwesomeIcons.user,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Profile',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.payment,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Payment',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.swap_horizontal_circle,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Transactions',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.chat_bubble,
                    color: Colors.white,
                  ),
                  title: Text(
                    'FAQ',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.contact_mail,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Contact us',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    FontAwesomeIcons.question,
                    color: Colors.white,
                  ),
                  title: Text(
                    'How it works?',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Share',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: const Icon(
                FontAwesomeIcons.infinity,
                color: Colors.white,
              ),
              title: Text(
                'Power by Kacha',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
