import 'package:andraslaundry/Screens/Admin/responsive.dart';
import 'package:flutter/material.dart';

import '../MenuController.dart';

class HeaderLayanan extends StatelessWidget {
  const HeaderLayanan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!responsive.isDesktop(context)) Menu(),
        Text(
          "Layanan",
          style: Theme.of(context).textTheme.bodySmall,
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
