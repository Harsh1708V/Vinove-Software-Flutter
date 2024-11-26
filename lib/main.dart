import 'package:flutter/material.dart';
import './screens/attendance_screen.dart'; // Corrected import path for AttendancePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/attendance': (context) =>
            const AttendancePage(), // Updated route to use the correct AttendancePage
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.timer,
                  title: 'Timer',
                  isSelected: false,
                  route: null, // No navigation for this item
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.calendar_today,
                  title: 'Attendance',
                  isSelected: true, // Selected item
                  route: '/attendance', // Navigate to Attendance page
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.bar_chart,
                  title: 'Activity',
                  isSelected: false,
                  route: null, // No navigation for this item
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.access_time,
                  title: 'Timesheet',
                  isSelected: false,
                  route: null, // No navigation for this item
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.insert_chart,
                  title: 'Report',
                  isSelected: false,
                  route: null, // No navigation for this item
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.location_pin,
                  title: 'Jobsite',
                  isSelected: false,
                  route: null, // No navigation for this item
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.people,
                  title: 'Team',
                  isSelected: false,
                  route: null, // No navigation for this item
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.time_to_leave,
                  title: 'Time off',
                  isSelected: false,
                  route: null, // No navigation for this item
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.schedule,
                  title: 'Schedules',
                  isSelected: false,
                  route: null, // No navigation for this item
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4a39b6), Color(0xFF6a4dbb)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 40,
              color: Color(0xFF4a39b6),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Cameron Williamson',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'cameronwilliamson@gmail.com',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool isSelected,
    String? route,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? const Color(0xFF4a39b6) : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFF4a39b6) : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: route != null
          ? () {
              Navigator.pushNamed(context, route);
            }
          : null, // Disable navigation for unlinked items
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: _buildDrawer(context),
      body: const Center(child: Text('Home Page Content')),
    );
  }
}
