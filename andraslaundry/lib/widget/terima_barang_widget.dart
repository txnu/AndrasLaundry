import 'package:flutter/material.dart';

class TerimaBarang extends StatelessWidget {
  const TerimaBarang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            'Halaman Terima Barang',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
