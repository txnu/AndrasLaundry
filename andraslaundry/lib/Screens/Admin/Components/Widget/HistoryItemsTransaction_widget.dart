import 'package:flutter/material.dart';

class HistoryItemsTransaction extends StatelessWidget {
  const HistoryItemsTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 230,
                  child: Text(
                    "Tanu Wijaya",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  width: 230,
                  child: Text(
                    "324ffdsfafa23",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  width: 230,
                  child: Text(
                    "Selesai",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  width: 230,
                  child: Text(
                    "25 Maret 2024",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 2,
          color: Colors.grey[500],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 230,
                child: Text(
                  "Dak Tau siapa",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                width: 230,
                child: Text(
                  "324ffdsfafa23",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                width: 230,
                child: Text(
                  "Selesai",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                width: 230,
                child: Text(
                  "25 Maret 2024",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
