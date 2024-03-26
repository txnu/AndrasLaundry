import 'package:andraslaundry/Screens/Admin/responsive.dart';
import 'package:flutter/material.dart';

import '../MenuController.dart';

class HeaderTransaction extends StatelessWidget {
  const HeaderTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!responsive.isDesktop(context)) Menu(),
        Text(
          "Transaksi",
          style: Theme.of(context).textTheme.headline4,
        ),
        Spacer(),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.rotate_left_rounded,
              size: 40.0,
            )),
      ],
    );
  }
}
