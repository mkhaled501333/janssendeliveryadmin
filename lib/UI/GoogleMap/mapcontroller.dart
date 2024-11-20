// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_custom_marker/google_maps_custom_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:janssendeliveryadmin/UI/carDataGrid/carDataGrid.dart';

class MapProviderController extends ChangeNotifier {
  final Completer<GoogleMapController> controllerv =
      Completer<GoogleMapController>();
  Set<Marker> markers = {};
  MapType currentMapType = MapType.normal;

  Future<void> gotoLocation(DataModel val, LatLng latLng) async {
    Marker pinMarker = await GoogleMapsCustomMarker.createCustomMarker(
      marker: Marker(
        markerId: MarkerId('pin'),
        position: latLng,
      ),
      shape: MarkerShape.pin,
      title: '99',
    );

    Marker circleMarker = await GoogleMapsCustomMarker.createCustomMarker(
      marker: Marker(
        markerId: MarkerId('circle'),
        position: latLng,
      ),
      shape: MarkerShape.circle,
      title: '99',
    );

    Marker bubbleMarkerCustomized =
        await GoogleMapsCustomMarker.createCustomMarker(
      marker: const Marker(
        markerId: MarkerId('bubble'),
        position: LatLng(49.02, -123),
      ),
      shape: MarkerShape.bubble,
      title: 'Customize Me!',
      backgroundColor: GoogleMapsCustomMarkerColor.markerYellow.withOpacity(.8),
      foregroundColor: Colors.black,
      textSize: 38,
      enableShadow: false,
      padding: 150,
      textStyle: const TextStyle(decoration: TextDecoration.underline),
      imagePixelRatio: 1.5,
      bubbleOptions: BubbleMarkerOptions(
        anchorTriangleWidth: 32,
        anchorTriangleHeight: 48,
        cornerRadius: 12,
      ),
    );
    markers.addAll({circleMarker});
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
