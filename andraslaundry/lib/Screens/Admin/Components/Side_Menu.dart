import 'package:andraslaundry/Screens/Admin/HomeAdminScreens.dart';
import 'package:andraslaundry/Screens/Admin/Screens/transaction_screen.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.textColor});

  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueAccent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset(
                "assets/images/laundry.png",
                height: 80,
                width: 80,
              ),
            ),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/menu_dashboard.svg",
              press: () {
              },
              textColor: textColor,
            ),
            DrawerListTile(
              title: "Transaksi",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransaksiScreen(),
                  ),
                );
              },
              textColor: textColor,
            ),
            DrawerListTile(
              title: "Riwayat Transaksi",
              svgSrc: "assets/icons/menu_task.svg",
              press: () {},
              textColor: textColor,
            ),
            DrawerListTile(
              title: "Setting",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {},
              textColor: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
