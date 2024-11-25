import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteScreen extends StatefulWidget {
  final String startLocation;
  final String stopLocation;

  const RouteScreen({super.key, required this.startLocation, required this.stopLocation});

  @override
  RouteScreenState createState() => RouteScreenState(); // Remove the underscore
}

class RouteScreenState extends State<RouteScreen> { // Remove the underscore
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Start Location: ${widget.startLocation}'),
                Text('Stop Location: ${widget.stopLocation}'),
                const Text('Total KMs: 10 km'),
                const Text('Total Duration: 30 minutes'),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              polylines: {
                const Polyline(
                  polylineId: PolylineId('route'),
                  color: Colors.blue,
                  points: [
                    LatLng(45.521563, -122.677433),
                    LatLng(45.531563, -122.687433),
                    LatLng(45.541563, -122.697433),
                  ],
                ),
              },
              markers: {
                Marker(
                  markerId: const MarkerId('stop1'),
                  position: const LatLng(45.531563, -122.687433),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
