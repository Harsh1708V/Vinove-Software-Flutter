import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _buildDrawerItem(
            context,
            title: 'Attendance',
            route: '/attendance',
          ),
          _buildDrawerItem(
            context,
            title: 'History',
            route: '/',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required String title, required String route}) {
    return ListTile(
      title: Text(title),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.teal, // Change this to your desired color
      elevation: 10.0, // Adjust shadow depth if needed
      onPressed: () {
        // Show the popup when the button is clicked
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Options'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Choose an option below:'),
                  const SizedBox(height: 16.0), // Add spacing
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the popup
                      // Add your FAQ logic here
                    },
                    child: const Text('FAQ'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the popup
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add), // Move child to the end
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.villa),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.question_answer),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      drawer: _buildDrawer(context),
      body: const Center(child: Text('Home Page')),
      floatingActionButton: _buildFloatingActionButton(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
