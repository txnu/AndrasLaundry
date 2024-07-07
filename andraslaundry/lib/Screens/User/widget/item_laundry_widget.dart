// ignore_for_file: unused_local_variable, unused_label

import 'package:andraslaundry/Utils/constant.dart';
import 'package:andraslaundry/api/configAPI.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

var paketLaundry = "-1";
var hargaPaketLaundry = "-1";
var layanan = "-1";
var promo = "-1";

class itemLaundry extends StatefulWidget {
  final String userId;

  const itemLaundry({Key? key, required this.userId}) : super(key: key);

  @override
  State<itemLaundry> createState() => _itemLaundryState();
}

class _itemLaundryState extends State<itemLaundry> {
  String? paketLaundry;
  String? layanan;
  String? promo;
  late String uid = widget.userId;

  var dio = Dio();
  Response? responsePaketLaundry;
  Response? responseLayanan;
  Response? responseUser;
  Response? responseTransaksi;
  Response? responsePromo;

  List _paketLaundryItems = [];
  List _LayananItems = [];
  List _PromoItems = [];

  TextEditingController? _txtTujuanController;
// GET Promo
  getPromo() async {
    bool status;
    try {
      responsePromo = await dio.get(urlGetAllPromo);
      status = responsePromo!.statusCode == 200;
      if (status) {
        setState(() {
          _PromoItems = responsePromo!.data['data'];
        });
      } else {
        print("Error");
      }
    } catch (e) {}
  }

// GET Paket Laundry
  getPaketLaundry() async {
    bool status;
    try {
      responsePaketLaundry = await dio.get(urlGetAllPaket);
      status = responsePaketLaundry!.data['sukses'];
      if (status) {
        setState(() {
          _paketLaundryItems = responsePaketLaundry!.data['data'];
        });
      } else {
        print("Error");
      }
    } catch (e) {}
  }

//GET Layanan
  getLayanan() async {
    bool status;
    try {
      responseLayanan = await dio.get(urlGetAllLayanan);
      status = responseLayanan!.data['sukses'];
      if (status) {
        setState(() {
          _LayananItems = responseLayanan!.data['data'];
        });
      } else {
        print("Error");
      }
    } catch (e) {}
  }

//Handle Refresh
  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));

    getPaketLaundry();
  }

  @override
  void initState() {
    super.initState();
    getUser();
    getPaketLaundry();
    getLayanan();
    getPromo();
    paketLaundry = "-1";
    layanan = "-1";
    promo = "-1";
  }

  @override
  void dispose() {
    _txtTujuanController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late TextEditingController namalengkapController;
    late TextEditingController teleponController;
    late TextEditingController alamatController;

    namalengkapController = TextEditingController(text: namalengkap);
    teleponController = TextEditingController(text: telepon);
    alamatController = TextEditingController(text: alamat);

    String? _selectedPaketId;
    String? _selectedLayananId;
    String? _selectedPromoId;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transaksi",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo,
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Form(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/laundry.png",
                    height: 140,
                    width: 140,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: namalengkapController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "Nama Pelanggan",
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black), // Add this line
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: teleponController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "No. Handphone",
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black), // Add this line
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: alamatController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "Alamat",
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black), // Add this line
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    value: paketLaundry,
                    items: [
                      DropdownMenuItem(
                        enabled: true,
                        child: Text("Pilih Paket Laundry"),
                        value: "-1",
                      ),
                      ..._paketLaundryItems.map((item) {
                        onTap:
                        () {
                          setState(() {
                            _selectedPaketId = item['idPaket'].toString();
                          });
                        };
                        return DropdownMenuItem(
                          child: IntrinsicWidth(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 140,
                                      child: Container(
                                        child: Text(
                                          item['namapaket'],
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Container(
                                        child: Text(
                                          "Rp${item['harga'].toString()}/Kg",
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          value: "${item['_id'].toString()}",
                        );
                      })
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        paketLaundry = value!;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    value: layanan,
                    items: [
                      DropdownMenuItem(
                        enabled: true,
                        child: Text("Pilih Layanan"),
                        value: "-1",
                      ),
                      ..._LayananItems.map((itemLayanan) {
                        onTap:
                        () {
                          setState(() {
                            _selectedPaketId =
                                itemLayanan['idLayanan'].toString();
                          });
                        };
                        return DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              children: [
                                Text(itemLayanan['layanan']),
                              ],
                            ),
                          ),
                          value: "${itemLayanan['_id'].toString()}",
                        );
                      })
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        layanan = value!;

                        // if (value == "65d7943dbf94178acaa78f77") {
                        //   // replace "specific_package_id" with the actual package id you want to trigger the text field
                        //   _txtTujuanController = TextEditingController();
                        // } else {
                        //   _txtTujuanController?.dispose();
                        //   _txtTujuanController = null;
                        // }
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (_PromoItems.isNotEmpty)
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      value: promo,
                      items: [
                        DropdownMenuItem(
                          enabled: false,
                          child: Text(
                            "Pilih Promo",
                          ),
                          value: "-1",
                        ),
                        ..._PromoItems.map((item) {
                          // onTap:
                          // () {
                          //   setState(() {
                          //     _selectedPromoId = item['idPromo'].toString();
                          //   });
                          // };
                          return DropdownMenuItem(
                            child: IntrinsicWidth(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: 160,
                                          child: Container(
                                            child: Text(
                                              item['promo'],
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: 80,
                                          child: Container(
                                            child: Text(
                                              "Rp${item['potongan']}",
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            value: "${item['_id'].toString()}",
                          );
                        })
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          promo = value!;
                        });
                      },
                    ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      prosesTransaksi();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "Konfirmasi",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //GET USER
  var getDataUser;
  var namalengkap;
  var alamat;
  var telepon;
  var username;
  Future<void> getUser() async {
    try {
      bool status;

      responseUser = await dio
          .get('$urlGetByIdUser${widget.userId}', data: {'id': widget.userId});
      status = responseUser!.data['sukses'];

      if (status) {
        getDataUser = responseUser!.data['data'];

        setState(() {
          namalengkap = getDataUser['namalengkap'];
          telepon = getDataUser['telepon'];
          alamat = getDataUser['alamat'];
        });
      }
    } catch (e) {}
  }

//Create Transaksi
  void prosesTransaksi() async {
    utilApps.showDialog(context);

    bool status;
    var msg;

    try {
      responseTransaksi = await dio.post(urlCreateTransaksi, data: {
        'idUser': uid,
        'idPaket': paketLaundry,
        'idLayanan': layanan,
        'idPromo': promo,
      });
      status = responseTransaksi!.data['sukses'];
      msg = responseTransaksi!.data['msg'];

      if (status) {
        AwesomeDialog(
          context: context,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: true,
          title: 'Berhasil',
          desc:
              'Proses Transaksimu berhasil, silahkan tunggu konfirmasi mimin ya😊',
          btnOkOnPress: () {
            utilApps.hideDialog(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => itemLaundry(
                  userId: widget.userId,
                ),
              ),
            );
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.error,
          showCloseIcon: true,
          title: 'Gagal',
          desc: 'Aduh Transaksi Kamu Gagal karna $msg',
          btnOkOnPress: () {
            utilApps.hideDialog(context);
          },
        ).show();
      }
    } catch (e) {}
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Dio>('dio', dio));
  }
}
