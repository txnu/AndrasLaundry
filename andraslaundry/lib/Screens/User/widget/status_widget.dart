// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  // Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Status Laundry'),
            backgroundColor: Colors.green[700],
          ),
          body: Text('a')),
    );
  }
}
