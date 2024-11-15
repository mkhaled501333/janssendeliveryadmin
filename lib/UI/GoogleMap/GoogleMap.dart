// ignore_for_file: unused_element

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final Completer<GoogleMapController> _controller =
    Completer<GoogleMapController>();

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: {
        const Marker(
          markerId: MarkerId("value"),
          infoWindow: InfoWindow(title: "tittle"),
          position: LatLng(30.4018873, 31.487725),
        )
      },
      mapType: MapType.satellite,
      initialCameraPosition: const CameraPosition(
        target: LatLng(30.4018873222, 31.487725333),
        zoom: 7,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}

Future<void> gotoLocation(LatLng latLng) async {
  CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: latLng,
      tilt: 59.440717697143555,
      zoom: 20.151926040649414);

  GoogleMapController controller = await _controller.future;
  await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
}
