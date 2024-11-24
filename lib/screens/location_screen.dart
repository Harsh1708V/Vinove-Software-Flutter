import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_tracking_app/screens/route_screen.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  final String memberName;
  final Position initialPosition;

  LocationScreen({required this.memberName, required this.initialPosition});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController mapController;
  late LatLng _center;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _center = LatLng(widget.initialPosition.latitude, widget.initialPosition.longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.memberName}\'s Location'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('current_location'),
                  position: _center,
                  infoWindow: InfoWindow(title: 'Current Location'),
                ),
              },
            ),
          ),
          Container(
            height: 200,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Visited Locations'),
                    TextButton(
                      onPressed: () => _selectDate(context),
                      child: Text('${selectedDate.toLocal()}'.split(' ')[0]),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Location ${index + 1}'),
                        subtitle: Text('Visited at ${DateTime.now().subtract(Duration(hours: index)).toString().split('.')[0]}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RouteScreen(
                                startLocation: 'Location $index',
                                stopLocation: 'Location ${index + 1}',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

