import 'package:andraslaundry/Screens/Admin/Screens/dashboard_screen.dart';
import 'package:andraslaundry/Screens/Admin/responsive.dart';
import 'package:flutter/material.dart';

import '../MenuController.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!responsive.isDesktop(context)) Menu(),
        Text(
          "Dashboard",
        ),
        Spacer(),
        Expanded(
          child: SearchField(),
        ),
        SizedBox(
          width: 10,
        ),
        ProfileCard()
      ],
    );
  }
}
