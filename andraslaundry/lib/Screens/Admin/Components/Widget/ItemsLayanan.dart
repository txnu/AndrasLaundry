import 'package:flutter/material.dart';

class ItemsLayanan extends StatelessWidget {
  const ItemsLayanan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 230,
                child: Text(
                  "Antar Jemput",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  size: 35,
                  color: Colors.red,
                ),
              ),
            ],
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Langsung Ke Lokasi",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  size: 35,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 2,
          color: Colors.grey[500],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 230,
              child: Text(
                "Antar Jemput",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                size: 35,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                size: 35,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
