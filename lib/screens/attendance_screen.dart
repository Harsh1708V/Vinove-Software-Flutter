import 'package:flutter/material.dart';
import 'location_screen.dart';  // Import the LocationPage

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  final List<Map<String, dynamic>> _members = const [
    {
      'name': 'Wade Warren',
      'id': 'WSL0030',
      'status': 'WORKING',
      'timeIn': '09:30 am',
      'timeOut': ''
    },
    {
      'name': 'Esther Howard',
      'id': 'WSL0034',
      'status': '',
      'timeIn': '09:30 am',
      'timeOut': '06:40 pm'
    },
    {
      'name': 'Cameron Williamson',
      'id': 'WSL0054',
      'status': '',
      'timeIn': 'NOT LOGGED-IN YET',
      'timeOut': ''
    },
    {
      'name': 'Brooklyn Simmons',
      'id': 'WSL0076',
      'status': '',
      'timeIn': '09:30 am',
      'timeOut': '06:40 pm'
    },
    {
      'name': 'Savannah Nguyen',
      'id': 'WSL0065',
      'status': '',
      'timeIn': '09:30 am',
      'timeOut': '06:40 pm'
    },
    {
      'name': 'Leslie Alexander',
      'id': 'WSL0069',
      'status': '',
      'timeIn': '09:30 am',
      'timeOut': '06:40 pm'
    },
    {
      'name': 'Kathryn Murphy',
      'id': 'WSL0095',
      'status': '',
      'timeIn': '09:30 am',
      'timeOut': '06:40 pm'
    },
  ];

  Widget _buildMemberTile(BuildContext context, Map<String, dynamic> member) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[300],
          child: Icon(
            Icons.person,
            color: member['status'] == 'WORKING' ? Colors.green : Colors.red,
          ),
        ),
        title: Row(
          children: [
            Text(member['name']),
            const SizedBox(width: 8),
            Text(
              '(${member['id']})',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show In Time and Out Time for all members
            Row(
              children: [
                Text(member['timeIn']),
                const SizedBox(width: 8),
                // Add Upward Arrow next to timeIn
                if (member['timeIn'] != 'NOT LOGGED-IN YET') ...[
                  const Icon(Icons.arrow_outward, color: Colors.green, size: 16),
                ],
                const SizedBox(width: 16),
                if (member['timeOut'].isNotEmpty) ...[
                  Text(member['timeOut']),
                  const SizedBox(width: 8),
                  // Add Downward Arrow next to timeOut
                  const Icon(Icons.call_received, color: Colors.red, size: 16),
                ],
                if (member['status'] == 'WORKING') ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.error,
                      color: Colors.black87,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    member['status'],
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: GestureDetector(
          onTap: () {
            if (member['name'] == 'Wade Warren') {
              // Navigate to the location screen for Wade Warren
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationPage(member: member),
                ),
              );
            }
          },
          child: Icon(
            Icons.gps_fixed,
            color: member['name'] == 'Wade Warren' ? Colors.blue : Colors.grey, // Change color here
          ),
        ),
        isThreeLine: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATTENDANCE', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF4a39b6),
      ),
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
