import 'package:andraslaundry/Screens/User/widget/pelayanan_widget.dart';
import 'package:andraslaundry/api/configAPI.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

var paketLaundry = "-1";
var layanan = "-1";
var hargaPaketLaundry = "-1";

class itemLaundry extends StatefulWidget {
  final String userId;
  const itemLaundry(Key? key, this.userId)
      : super(key: key);

  @override
  State<itemLaundry> createState() => _itemLaundryState();
}

class _itemLaundryState extends State<itemLaundry> {
  String? idPaket = "";
  String? idLayanan = "";

  var dio = Dio();
  Response? response;
  Response? response2;
  Response? response3;
  List _paketLaundryItems = [];
  List _LayananItems = [];

  TextEditingController? _txtTujuanController;

// GET Paket Laundry
  getPaketLaundry() async {
    bool status;
    try {
      response = await dio.get(urlGetAllPaket);
      status = response!.data['sukses'];
      if (status) {
        setState(() {
          _paketLaundryItems = response!.data['data'];
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
      response2 = await dio.get(urlGetAllLayanan);
      status = response2!.data['sukses'];
      if (status) {
        setState(() {
          _LayananItems = response2!.data['data'];
        });
      } else {
        print("Error");
      }
    } catch (e) {}
  }

// POST Booking
  Transaksi() async {
    try {} catch (e) {}
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
    paketLaundry = "-1";
    layanan = "-1";
  }

  @override
  void dispose() {
    _txtTujuanController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController namalengkapController;
    TextEditingController teleponController;

    namalengkapController = TextEditingController(text: namalengkap);
    teleponController = TextEditingController(text: telepon);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Item Laundry"),
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
                    keyboardType: TextInputType.text,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "a",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: teleponController,
                    keyboardType: TextInputType.number,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "a",
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

                        if (value == "65d7943dbf94178acaa78f77") {
                          // replace "specific_package_id" with the actual package id you want to trigger the text field
                          _txtTujuanController = TextEditingController();
                        } else {
                          _txtTujuanController?.dispose();
                          _txtTujuanController = null;
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (_txtTujuanController != null)
                    TextFormField(
                      controller: _txtTujuanController,
                      decoration: InputDecoration(
                        labelText: "Tambah Titik Jemput Disini ya😊",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pelayanan(),
                        ),
                      );
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

      response3 = await dio
          .get('$urlGetByIdUser${widget.userId}', data: {'id': widget.userId});
      status = response3!.data['sukses'];

      if (status) {
        getDataUser = response!.data['data'];

        setState(() {
          namalengkap = getDataUser['namalengkap'];
          telepon = getDataUser['telepon'];
        });
      }
    } catch (e) {}
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Dio>('dio', dio));
  }
}
