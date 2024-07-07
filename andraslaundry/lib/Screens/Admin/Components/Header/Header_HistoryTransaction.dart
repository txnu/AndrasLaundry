import 'package:andraslaundry/Screens/Admin/responsive.dart';
import 'package:flutter/material.dart';

import '../MenuController.dart';

class HeaderHistoryTransaction extends StatelessWidget {
  const HeaderHistoryTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!responsive.isDesktop(context)) Menu(),
        Text(
          "Riwayat Transaksi",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.rotate_left_rounded,
            size: 40.0,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.save_alt,
            size: 40.0,
          ),
        ),
      ],
    );
  }
}
