import 'package:billpayment/constants/variables/const.dart';
import 'package:billpayment/custom_widgets/custom_bottom_menu.dart';
import 'package:billpayment/custom_widgets/custom_drawer.dart';
import 'package:billpayment/screens/bill_detail_screen.dart';
import 'package:billpayment/screens/home_screen.dart';
import 'package:billpayment/screens/payment_screen.dart';
import 'package:billpayment/screens/profile_screen.dart';
import 'package:billpayment/screens/settings_screen.dart';
import 'package:billpayment/screens/transaction_detail_screen.dart';
import 'package:billpayment/screens/transaction_history_screen.dart';
import 'package:billpayment/service/ui_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiServiceProvider>(context);
    List<Widget> _widgetOptions = <Widget>[
      HomeScreen(),
      TransactionHistoryScreen(),
      PaymentScreen(),
      SettingScreen(),
      ProfileScreen(),
      BillDetailScreen(),
      TransactionDetailScreen(),
    ];
    return SafeArea(
      child: Scaffold(
        drawer: BillPaymentDrawer(),
        body: Center(
          child: _widgetOptions.elementAt(uiProvider.activeTabIndex),
        ),
        floatingActionButton: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0,
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
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.green],
                      ),
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.currency_exchange),
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
          height: BOTTOM_SHEET_HEIGHT,
          shape: const CircularNotchedRectangle(),
          color: Color.fromARGB(255, 45, 159, 204),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomBottomMenu(
                  onClick: () => {uiProvider.changeIndex(0)},
                  icon: Icons.home,
                  menuName: "home".tr(),
                ),
                CustomBottomMenu(
                  onClick: () => {uiProvider.changeIndex(1)},
                  icon: Icons.swap_horizontal_circle,
                  menuName: "transactions".tr(),
                ),
                // CustomBottomMenu(
                //   onClick: () => {uiProvider.changeIndex(2)},
                //   icon: Icons.payment,
                //   menuName: "Payment",
                // ),
                Container(),
                CustomBottomMenu(
                  onClick: () => {uiProvider.changeIndex(3)},
                  icon: Icons.settings,
                  menuName: "settings".tr(),
                ),
                CustomBottomMenu(
                  onClick: () => {uiProvider.changeIndex(4)},
                  icon: Icons.person,
                  menuName: "account".tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
