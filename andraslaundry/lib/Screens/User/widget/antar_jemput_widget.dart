import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AntarJemputWidget extends StatefulWidget {
  const AntarJemputWidget({super.key});

  @override
  State createState() => _AntarJemputWidgetState();
}

class _AntarJemputWidgetState extends State {
  late GoogleMapController mapController;

  static const LatLng sourceLocation =
      LatLng(-0.05676061064958758, 109.29412000498971);

  List<LatLng> polylineCoordinates = [];

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dimanakah aku?'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: sourceLocation, zoom: 14),
          polylines: {
            Polyline(
              polylineId: PolylineId("route"),
              color: Colors.blue,
              width: 5,
              points: polylineCoordinates,
            )
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
