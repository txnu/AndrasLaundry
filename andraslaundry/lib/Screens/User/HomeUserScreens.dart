import 'package:andraslaundry/API/configAPI.dart';
import 'package:andraslaundry/Screens/User/widget/antar_jemput_widget.dart';
import 'package:andraslaundry/Screens/User/widget/item_laundry_widget.dart';
import 'package:andraslaundry/Screens/User/widget/pelayanan_widget.dart';
import 'package:andraslaundry/Screens/User/widget/profile_widget.dart';
import 'package:andraslaundry/Screens/User/widget/terima_barang_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeUserScreens extends StatefulWidget {
  final String userId;
  final String password;
  HomeUserScreens({
    Key? key,
    required this.userId,
    required this.password,
  }) : super(key: key);

  @override
  State<HomeUserScreens> createState() => _HomeUserScreensState();
}

class _HomeUserScreensState extends State<HomeUserScreens> {
  var height, width;

  List imgData = [
    "assets/images/laundry.png",
    "assets/images/antarJemput.png",
    "assets/images/pelayanan.png",
    "assets/images/terimaBarang.png",
    "assets/images/promo.png"
  ];

  List titles = [
    "Item Laundry",
    "Antar Jemput",
    "Pelayanan",
    "Riwayat Laundry",
    "Informasi Promo"
  ];

  List pages = [
    itemLaundry(),
    AntarJemputWidget(),
    Pelayanan(),
    TerimaBarang(),
  ];

  List layanan = [];
  int myCurrentIndex = 0;

  //Refresh Page
  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));

    getUser();
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.indigo,
            width: width,
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(),
                    height: height * 0.24,
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 65, left: 20, right: 20),
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfilePage(
                                        userId: widget.userId,
                                        namalengkap: namalengkap,
                                        telepon: telepon,
                                        username: username,
                                        password: widget.password,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/profile.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 15,
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
                                height: 7,
                              ),
                              Text(
                                "Selamat Datang ${namalengkap}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
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
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
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
      ),
    );
  }

  //GET USER
  var dio = Dio();
  Response? response;
  var getDataUser;
  var namalengkap;
  var telepon;
  var username;

  Future<void> getUser() async {
    try {
      bool status;

      response = await dio
          .get('$urlGetByIdUser${widget.userId}', data: {'id': widget.userId});
      status = response!.data['sukses'];

      if (status) {
        getDataUser = response!.data['data'];

        setState(() {
          namalengkap = getDataUser['namalengkap'];
          telepon = getDataUser['telepon'];
          username = getDataUser['username'];
        });
      }
    } catch (e) {}
  }
}
