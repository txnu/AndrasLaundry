import 'package:andraslaundry/Screens/Admin/Components/Side_Menu.dart';
import 'package:andraslaundry/Screens/Admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

import 'Screens/AkunScreen.dart';
import 'Screens/LayananScreen.dart';
import 'Screens/PaketScreen.dart';
import 'Screens/PengaturanScreen.dart';
import 'Screens/RiwayatTransaksi.dart';
import 'Screens/TransactionScreen.dart';
import 'Screens/dashboard_screen.dart';

class HomeAdminScreens extends StatefulWidget {
  HomeAdminScreens({Key? key}) : super(key: key);

  @override
  State<HomeAdminScreens> createState() => _HomeAdminScreensState();
}

class _HomeAdminScreensState extends State<HomeAdminScreens> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    TransaksiScreen(),
    RiwayatTransaksiScreen(),
    LayananScreen(),
    PaketScreen(),
    AkunScreen(),
    PengaturanScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final textColor =
        brightness == Brightness.light ? Colors.black : Colors.white;

    return Scaffold(
      drawer: !responsive.isDesktop(context)
          ? SideMenu(
              textColor: textColor,
              onSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            )
          : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (responsive.isDesktop(context))
              Expanded(
                child: SideMenu(
                  textColor: textColor,
                  onSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            Expanded(
              flex: 5,
              child: _widgetOptions[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.textColor,
  }) : super(key: key);

  final String title, svgSrc;
  final Color textColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(svgSrc),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
