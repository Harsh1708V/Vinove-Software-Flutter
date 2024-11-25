import 'package:flutter/material.dart';
import 'location_screen.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  final List<Map<String, dynamic>> _members = const [
    {'name': 'Harsh', 'id': 1},
    {'name': 'Stark', 'id': 2},
    {'name': 'Mansi', 'id': 3},
    {'name': 'Kanika', 'id': 4},
    {'name': 'Niyati', 'id': 5},
  ];

  void _showMemberDetails(BuildContext context, String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Details for $name')),
    );
  }

  void _navigateToLocationPage(BuildContext context, Map<String, dynamic> member) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPage(member: member),
      ),
    );
  }

  Widget _buildMemberTile(BuildContext context, Map<String, dynamic> member) {
    return ListTile(
      title: Text(member['name']),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => _showMemberDetails(context, member['name']),
          ),
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () => _navigateToLocationPage(context, member),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: ListView.builder(
        itemCount: _members.length,
        itemBuilder: (context, index) {
          final member = _members[index];
          return _buildMemberTile(context, member);
        },
      ),
    );
  }
}
