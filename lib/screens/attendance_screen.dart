import 'package:flutter/material.dart';
import 'package:location_tracking_app/screens/location_screen.dart';
import 'package:geolocator/geolocator.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Map<String, dynamic>> members = [
    {'name': 'Mansi Varshney', 'status': 'Not Set', 'location': null},
    {'name': 'Arya Gupta', 'status': 'Not Set', 'location': null},
    {'name': 'Harsh Waibhav', 'status': 'Not Set', 'location': null},
    {'name': 'Kanika Kasana', 'status': 'Not Set', 'location': null},
    {'name': 'Niyati Kalia', 'status': 'Not Set', 'location': null},
  ];

  Future<void> _updateAttendance(int index, String status) async {
    setState(() {
      members[index]['status'] = status;
    });

    if (status == 'Present') {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          members[index]['location'] = position;
        });
      } catch (e) {
        print("Error getting location: $e");
        // Handle the error, maybe show a dialog to the user
      }
    } else {
      setState(() {
        members[index]['location'] = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(members[index]['name']),
            subtitle: Text('Status: ${members[index]['status']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: members[index]['status'],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _updateAttendance(index, newValue);
                    }
                  },
                  items: <String>['Not Set', 'Present', 'Absent']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                ),
                IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: members[index]['location'] != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationScreen(
                              memberName: members[index]['name'],
                              initialPosition: members[index]['location'],
                            ),
                          ),
                        );
                      }
                    : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

