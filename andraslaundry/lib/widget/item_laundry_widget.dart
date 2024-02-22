import 'package:andraslaundry/api/configAPI.dart';
import 'package:andraslaundry/widget/pelayanan_widget.dart';
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
  var dio = Dio();
  Response? response;
  Response? response2;
  List _paketLaundryItems = [];
  List _LayananItems = [];

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

  @override
  void initState() {
    super.initState();
    getPaketLaundry();
    getLayanan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Item Laundry"),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
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
                          padding: const EdgeInsets.all(0),
                          child: Row(
                            children: [
                              Text(item['namapaket']),
                              SizedBox(
                                width: 70,
                              ),
                              Text(
                                "Rp${item['harga'].toString()}/Kg",
                              )
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
                    });
                  },
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
    );
  }
}
