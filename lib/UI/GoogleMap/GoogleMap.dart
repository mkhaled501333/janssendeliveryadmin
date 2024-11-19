// ignore_for_file: unused_element
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:janssendeliveryadmin/UI/GoogleMap/mapcontroller.dart';
import 'package:provider/provider.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

Set<Polyline> polylines = {
  Polyline(
    polylineId: PolylineId('route1'),
    points: [
      LatLng(37.7749, -122.4194),
      LatLng(37.8051, -122.4300),
      LatLng(37.8070, -122.4093),
    ],
    color: Colors.blue,
    width: 4,
  ),
};

Set<Polygon> polygons = {
  Polygon(
    polygonId: PolygonId('area1'),
    points: [
      LatLng(37.7749, -122.4194),
      LatLng(37.8051, -122.4300),
      LatLng(37.8070, -122.4093),
    ],
    fillColor: Colors.green.withOpacity(0.3),
    strokeColor: Colors.green,
    strokeWidth: 2,
  ),
};

class MapSampleState extends State<MapSample> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapProviderController>(
      builder: (context, myType, child) {
        return Stack(
          children: [
            GoogleMap(
              polygons: polygons,
              markers: myType.markers,
              mapType: myType.currentMapType,
              initialCameraPosition: const CameraPosition(
                target: LatLng(30.4018873222, 31.487725333),
                zoom: 7,
              ),
              onMapCreated: (GoogleMapController controller) {
                myType.controllerv.complete(controller);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: () => myType.onMapTypeButtonPressed(),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.map, size: 36.0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
