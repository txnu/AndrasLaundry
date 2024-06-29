// ignore_for_file: unnecessary_null_comparison

import 'package:andraslaundry/api/configAPI.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Promo extends StatefulWidget {
  Promo({super.key});

  @override
  State<Promo> createState() => _PromoState();
}

class _PromoState extends State<Promo> {
  @override
  void initState() {
    super.initState();
    getPromo();
  }

  List _Promo = [];
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Promo",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _Promo != null
                      ? ListView.builder(
                          itemCount: _Promo.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 120,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            "${_Promo[index]['image']}",
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${_Promo[index]['promo']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "${_Promo[index]['keterangan']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              'Potongan : Rp${_Promo[index]['potongan']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : Center(
                          child: Text('Promo Tidak tersedia'),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  var dio = Dio();
  Response? responsePromo;

  // GET Paket Laundry
  getPromo() async {
    bool status;
    try {
      responsePromo = await dio.get(urlGetAllPromo);
      status = responsePromo!.statusCode == 200;
      if (status) {
        setState(() {
          _Promo = responsePromo!.data['data'];
          _isLoading = false;
        });
      } else {
        print("Error");
      }
    } catch (e) {}
  }
}
