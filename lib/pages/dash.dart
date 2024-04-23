import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Notifications'),
              content: const Column(
                children: [
            ListTile(
              leading: Icon(Icons.notification_important),
              title: Text('Notification 1'),
            ),
            ListTile(
              leading: Icon(Icons.notification_important),
              title: Text('Notification 2'),
            ),
            ListTile(
              leading: Icon(Icons.notification_important),
              title: Text('Notification 3'),
            ),
                ],
              ),
              actions: [
                TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
                ),
              ],
            );
          },
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('Employee ID'),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_bus),
              title: const Text('Bus Drivers'),
              onTap: () {
                Navigator.pushNamed(context, '/busInfo');
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Messages'),
              onTap: () {
                Navigator.pushNamed(context, '/messages');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Student Files'),
              onTap: () {
                Navigator.pushNamed(context, '/stdinfo');
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Bus Schedule'),
              onTap: () {
                Navigator.pushNamed(context, '/sched');
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Google Maps API will be placed here'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logout logic
          Navigator.pushNamed(context, 'lib/pages/login.dart');
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}