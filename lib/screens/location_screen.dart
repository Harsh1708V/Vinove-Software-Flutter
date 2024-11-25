import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class LocationPage extends StatefulWidget {
  final Map<String, dynamic> member;

  const LocationPage({super.key, required this.member});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = const LatLng(0.0, 0.0);
  bool _isLoading = true;
  String _errorMessage = '';
  DateTime _selectedDate = DateTime.now();
  final List<Map<String, dynamic>> _visitedLocations = [];

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _fetchVisitedLocations();
  }

  Future<void> _initializeLocation() async {
    final position = await _determineCurrentPosition();
    if (position != null) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });
      _moveCamera(_currentPosition);
      _startLocationUpdates();
    }
  }

  Future<Position?> _determineCurrentPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        _updateErrorMessage('Location services are disabled.');
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        _updateErrorMessage('Location permissions are denied.');
        return null;
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        ),
      );
    } catch (e) {
      _updateErrorMessage('Error getting location: $e');
      return null;
    }
  }

  void _updateErrorMessage(String message) {
    setState(() {
      _isLoading = false;
      _errorMessage = message;
    });
  }

  void _startLocationUpdates() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
      _moveCamera(_currentPosition);
    });
  }

  void _moveCamera(LatLng position) {
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(position));
    }
  }

  Future<void> _fetchVisitedLocations() async {
    // Simulated data fetch
    setState(() {
      _visitedLocations.addAll([
        {'location': const LatLng(28.4595, 77.0299), 'time': '10:00 AM'},
        {'location': const LatLng(28.4620, 77.0315), 'time': '12:30 PM'},
        {'location': const LatLng(28.4650, 77.0330), 'time': '02:45 PM'},
        {'location': const LatLng(28.4670, 77.0350), 'time': '04:00 PM'},
      ]);
    });
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Set<Marker> _buildMarkers() {
    final markers = <Marker>{
      Marker(
        markerId: const MarkerId('current_location'),
        position: _currentPosition,
        infoWindow: const InfoWindow(title: 'Your Location'),
      ),
    };

    for (var loc in _visitedLocations) {
      markers.add(Marker(
        markerId: MarkerId(loc['time']),
        position: loc['location'],
        infoWindow: InfoWindow(title: loc['time'], snippet: 'Visited'),
      ));
    }
    return markers;
  }

  Widget _buildTimeline() {
    return ListView(
      children: _visitedLocations.map((loc) {
        return ListTile(
          title: Text('Time: ${loc['time']}'),
          subtitle: Text(
              'Lat: ${loc['location'].latitude}, Lng: ${loc['location'].longitude}'),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location for ${widget.member['name']}')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Current Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _selectDate,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                    ? Center(child: Text(_errorMessage))
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _currentPosition,
                          zoom: 14.0,
                        ),
                        onMapCreated: (controller) => _mapController = controller,
                        markers: _buildMarkers(),
                      ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Timeline:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: _buildTimeline()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
