import 'package:andraslaundry/widget/antar_jemput_widget.dart';
import 'package:andraslaundry/widget/item_laundry_widget.dart';
import 'package:andraslaundry/widget/pelayanan_widget.dart';
import 'package:andraslaundry/widget/terima_barang_widget.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  String username;
  Dashboard({Key? key, this.username = ""}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var height, width;

  List imgData = [
    "images/laundry.png",
    "images/antarJemput.png",
    "images/pelayanan.png",
    "images/terimaBarang.png",
    "images/promo.png"
  ];

  List titles = [
    "Item Laundry",
    "Antar Jemput",
    "Pelayanan",
    "Riwayat Laundry",
    "Informasi Promo"
  ];

  List layanana = [];

  int myCurrentIndex = 0;

  List pages = [
    itemLaundry(),
    AntarJemputWidget(),
    Pelayanan(),
    TerimaBarang(),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.username.isNotEmpty) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.indigo,
          width: width,
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(),
                  height: height * 0.23,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 65, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.sort,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage("images/profile.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                          left: 25,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Beranda",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Selamat Datang ${(widget.username)}",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white54,
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  // height: height * 0.75,
                  width: width,
                  padding: EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      mainAxisSpacing: 25,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: imgData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => pages[index]));
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                imgData[index],
                                width: 100,
                              ),
                              Text(
                                titles[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
