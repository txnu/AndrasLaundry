import 'package:andraslaundry/Screens/Admin/Screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Dashboard",
          style: Theme.of(context).textTheme.headline6,
        ),
        Spacer(),
        Expanded(child: SearchField()),
        SizedBox(
          width: 10,
        ),
        ProfileCard()
      ],
    );
  }
}
