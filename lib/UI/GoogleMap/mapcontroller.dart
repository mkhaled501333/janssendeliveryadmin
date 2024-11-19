import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:janssendeliveryadmin/UI/carDataGrid/carDataGrid.dart';

class MapProviderController extends ChangeNotifier {
  final Completer<GoogleMapController> controllerv =
      Completer<GoogleMapController>();
  Set<Marker> markers = {};
  MapType currentMapType = MapType.normal;

  Future<void> gotoLocation(DataModel val, LatLng latLng) async {
    markers.addAll({
      Marker(
        markerId: const MarkerId("value"),
        infoWindow: InfoWindow(
            title: "car num : ${val.carnum} driver : ${val.drivername}"),
        position: latLng,
      )
    });
    notifyListeners();
    CameraPosition kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: latLng,
        tilt: 59.440717697143555,
        zoom: 20.151926040649414);
    GoogleMapController controller = await controllerv.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(kLake));
  }

  void onMapTypeButtonPressed() {
    currentMapType =
        currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    notifyListeners();
  }
}
