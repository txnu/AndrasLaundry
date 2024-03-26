import 'package:andraslaundry/Screens/Admin/Components/Header/Header_Layanan.dart';
import 'package:andraslaundry/Screens/Admin/Components/Widget/ItemsLayanan.dart';
import 'package:andraslaundry/Screens/Admin/constants.dart';
import 'package:flutter/material.dart';

class LayananScreen extends StatelessWidget {
  const LayananScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            HeaderLayanan(),
            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(right: 40),
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 230,
                                  child: Text(
                                    "Daftar Layanan",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ItemsLayanan(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
