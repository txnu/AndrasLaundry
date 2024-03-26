import 'package:andraslaundry/Screens/Admin/HomeAdminScreens.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key, required this.textColor, required this.onSelected})
      : super(key: key);

  final Color textColor;
  final ValueChanged<int> onSelected;

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
                onSelected(0);
              },
              textColor: textColor,
            ),
            DrawerListTile(
              title: "Transaksi",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                onSelected(1);
              },
              textColor: textColor,
            ),
            DrawerListTile(
              title: "Riwayat Transaksi",
              svgSrc: "assets/icons/menu_task.svg",
              press: () {
                onSelected(2);
              },
              textColor: textColor,
            ),
            DrawerListTile(
              title: "Layanan",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {
                onSelected(3);
              },
              textColor: textColor,
            ),
            DrawerListTile(
              title: "Paket",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {
                onSelected(4);
              },
              textColor: textColor,
            ),
            DrawerListTile(
              title: "Akun",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {
                onSelected(5);
              },
              textColor: textColor,
            ),
            DrawerListTile(
              title: "Setting",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {
                onSelected(6);
              },
              textColor: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
