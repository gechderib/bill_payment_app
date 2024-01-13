import 'package:billpayment/custom_widgets/custom_drawer.dart';
import 'package:billpayment/screens/home_screen.dart';
import 'package:billpayment/screens/profile_screen.dart';
import 'package:billpayment/screens/settings_screen.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiServiceProvider>(context);
    List<Widget> _widgetOptions = <Widget>[
      HomeScreen(),
      ProfileScreen(),
      SettingScreen(),
    ];
    return Scaffold(
      drawer: BillPaymentDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(uiProvider.activeTabIndex),
      ),
      floatingActionButton: Visibility(
        visible: true,
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(36)),
          child: Stack(
            children: [
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      color: const Color(0XFFF07AAC),
                      borderRadius: BorderRadius.circular(36)),
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      uiProvider.changeIndex(2);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.blue,
        child: Container(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    padding: const EdgeInsets.only(top: 10),
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      uiProvider.changeIndex(0);
                    },
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Home",
                    style: GoogleFonts.lato(
                        textStyle:
                            const TextStyle(fontSize: 8, color: Colors.white)),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                      padding: const EdgeInsets.only(top: 10),
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        uiProvider.changeIndex(1);
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.book,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                  Text(
                    "Resources",
                    style: GoogleFonts.lato(
                        textStyle:
                            const TextStyle(fontSize: 8, color: Colors.white)),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      padding: const EdgeInsets.only(top: 10),
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        uiProvider.changeIndex(2);
                      },
                      icon: const Icon(
                        Icons.help_outline_outlined,
                        color: Colors.white,
                      )),
                  Text(
                    "Help",
                    style: GoogleFonts.lato(
                        textStyle:
                            const TextStyle(fontSize: 8, color: Colors.white)),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                      padding: const EdgeInsets.only(top: 10),
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        uiProvider.changeIndex(3);
                      },
                      icon: const Icon(
                        Icons.help_outline_outlined,
                        color: Colors.white,
                      )),
                  Text(
                    "Help",
                    style: GoogleFonts.lato(
                        textStyle:
                            const TextStyle(fontSize: 8, color: Colors.white)),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                      padding: const EdgeInsets.only(top: 10),
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        uiProvider.changeIndex(4);
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.user,
                        color: Colors.white,
                      )),
                  Text(
                    "Profile",
                    style: GoogleFonts.lato(
                        textStyle:
                            const TextStyle(fontSize: 8, color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}