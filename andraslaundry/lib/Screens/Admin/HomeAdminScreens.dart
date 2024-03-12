import 'package:andraslaundry/Screens/Admin/Components/Side_Menu.dart';
import 'package:andraslaundry/Screens/Admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class HomeAdminScreens extends StatelessWidget {
  const HomeAdminScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final textColor =
        brightness == Brightness.light ? Colors.black : Colors.white;

    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(
                  textColor: textColor,
                ),
              ),
            if (!Responsive.isMobile(context))
              Expanded(
                  flex: 5,
                  child: SideMenu(
                    textColor: textColor,
                  )),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.textColor,
  });

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
