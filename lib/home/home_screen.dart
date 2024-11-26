import 'package:flutter/material.dart';

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
      // Define routes for navigation
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/attendance': (context) => const AttendancePage(),
        '/activity': (context) => const ActivityPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.check),
            title: const Text('Attendance'),
            onTap: () {
              Navigator.pushNamed(context, '/attendance');
            },
          ),
          ListTile(
            leading: const Icon(Icons.accessibility),
            title: const Text('Activity'),
            onTap: () {
              Navigator.pushNamed(context, '/activity');
            },
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ATTENDANCE')),
      drawer: _buildDrawer(context),
      body: const Center(child: Text('Home Page Content')),
    );
  }
}

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: const Center(child: Text('Attendance Page Content')),
    );
  }
}

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity')),
      body: const Center(child: Text('Activity Page Content')),
    );
  }
}
