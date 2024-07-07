// import 'dart:async';
import 'dart:convert';
import 'package:andraslaundry/API/configAPI.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class StatusWidget extends StatefulWidget {
  const StatusWidget({super.key});

  @override
  State createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State {
  late GoogleMapController mapController;

  // static const LatLng sourceLocation =
  //     LatLng(-0.05676061064958758, 109.29412000498971);

  List<LatLng> polylineCoordinates = [];
  final String userId =
      "66701b143d14c1a740e37b62"; // ID user yang akan difilter
  List<dynamic> transactions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    final response =
        await http.get(Uri.parse('$baseUrl/transaksi/getAllTransaksi'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final allTransactions = data['data'];
      setState(() {
        transactions = allTransactions
            .where((transaction) => transaction['idUser']['_id'] == userId)
            .toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  // Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan anda'),
        backgroundColor: Colors.green[700],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  title: Text(transaction['idPaket']['namapaket']),
                  subtitle: Text(
                      'Status: ${transaction['status']} | Berat: ${transaction['berat']}kg'),
                  trailing: ElevatedButton(
                    child: Text('Cek Status'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LaundryStatusPage(transaction: transaction),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class LaundryStatusPage extends StatefulWidget {
  final dynamic transaction;

  LaundryStatusPage({required this.transaction});

  @override
  _LaundryStatusPageState createState() => _LaundryStatusPageState();
}

class _LaundryStatusPageState extends State<LaundryStatusPage> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    // Set _currentStep based on transaction status
    _currentStep = widget.transaction['status'];
  }

  List<Step> _laundrySteps(int currentStatus) {
    List<String> statusList = [
      'Driver menjemput pakaian anda',
      'Pakaian sedang ditimbang',
      'Pakaian sedang diberi kode',
      'Pakaian sedang dilakukan pengecekan',
      'Pakaian sedang dicuci',
      'Pakaian sedang dikeringkan',
      'Pakaian sedang disetrika',
      'Pakaian sedang dipacking',
      'Laundry Selesai',
      'Driver mengantar pakaian anda',
      'Pengantaran dan pembayaran selesai'
    ];

    return List.generate(statusList.length, (index) {
      return Step(
        title: Text(statusList[index]),
        content: SizedBox.shrink(), // Empty content
        isActive: index <= currentStatus,
        state: index <= currentStatus ? StepState.complete : StepState.indexed,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    int currentStatus = widget.transaction['status'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Laundry Status'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stepper(
              steps: _laundrySteps(currentStatus),
              currentStep: currentStatus,
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Container(); // Remove buttons
              },
              onStepTapped: (step) {
                // Do nothing
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
