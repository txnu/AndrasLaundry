import 'package:andraslaundry/Screens/User/widget/pelayanan_widget.dart';
import 'package:andraslaundry/api/configAPI.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

var paketLaundry = "-1";
var layanan = "-1";
var hargaPaketLaundry = "-1";

class itemLaundry extends StatefulWidget {
  const itemLaundry({super.key});

  @override
  State<itemLaundry> createState() => _itemLaundryState();
}

class _itemLaundryState extends State<itemLaundry> {
  // static const LatLng sourceLocation =
  //     LatLng(-0.05676061064958758, 109.29412000498971);

  var dio = Dio();
  Response? response;
  Response? response2;
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

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));

    getPaketLaundry();
  }

  @override
  void initState() {
    super.initState();
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
                    "images/laundry.png",
                    height: 140,
                    width: 140,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Nama Pelanggan",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "No. Handphone",
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
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: IntrinsicWidth(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          "Booking",
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
}
