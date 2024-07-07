import 'package:andraslaundry/api/configAPI.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RiwayatLaundryWidget extends StatefulWidget {
  final String userId; // Add userId parameter

  RiwayatLaundryWidget({super.key, required this.userId});

  @override
  _RiwayatLaundryWidgetState createState() => _RiwayatLaundryWidgetState();
}

class _RiwayatLaundryWidgetState extends State<RiwayatLaundryWidget> {
  var dio = Dio();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _originalListTransaksi = [];
  List<Map<String, dynamic>> _filteredListTransaksi = [];

  @override
  void initState() {
    super.initState();
    getTransaksibyUserId(widget.userId);
  }

  Future<void> getTransaksibyUserId(String userId) async {
    bool status;
    try {
      var responseRiwayatTransaksi =
          await dio.get('$urlGetbyIdTransaksi$userId');
      status = responseRiwayatTransaksi.statusCode == 200;
      if (status) {
        setState(() {
          var data = responseRiwayatTransaksi.data['data'];
          _originalListTransaksi =
              List<Map<String, dynamic>>.from(data.map((item) => {
                    'tanggal': DateTime.parse(item['tanggal']),
                    'berat': item['berat'],
                    'idPaket': item['idPaket']['namapaket'],
                  }));
          _filteredListTransaksi = _originalListTransaksi;
        });
        print("Data fetched successfully: $_originalListTransaksi");
      } else {
        print("Error: ${responseRiwayatTransaksi.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  void _filterSearchResults(String query) {
    List<Map<String, dynamic>> filteredList = [];
    if (query.isNotEmpty) {
      filteredList = _originalListTransaksi
          .where((item) =>
              DateFormat('yyyy-MM-dd')
                  .format(item['tanggal'])
                  .contains(query) ||
              item['berat'].toString().contains(query) ||
              item['idPaket'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      filteredList = _originalListTransaksi;
    }
    setState(() {
      _filteredListTransaksi = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Riwayat",
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
            Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: _searchController,
                onChanged: _filterSearchResults,
                decoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredListTransaksi.length,
                itemBuilder: (context, index) {
                  var item = _filteredListTransaksi[index];
                  return Padding(
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
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Image.asset(
                              "assets/images/laundry.png",
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(item['tanggal']),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${item['berat']} kg",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                item['idPaket'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
