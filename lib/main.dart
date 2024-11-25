import 'package:flutter/material.dart';
import 'screens/attendance_screen.dart';
import 'home/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/': (context) => const HomePage(),
      '/attendance': (context) => const AttendancePage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: _buildRoutes(),
    );
  }
}
