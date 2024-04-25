import 'package:flutter/material.dart';
import 'busInfo.dart';
import 'stdinfo.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
        backgroundColor: Colors.white,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: [
            DrawerHeader(
              child: Image.asset(
                'lib/assets/images/logo.png',
                width: 50.0,
                height: 50.0,
              ),
            ),
            ListTile(
              selectedColor: Colors.grey[400],
              leading: Icon(
                Icons.dashboard,
                color: Colors.blue[900],
              ),
              title: const Text('Dashboard',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 15.0,
                  )),
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
            ListTile(
              selectedColor: Colors.grey[400],
              leading: Icon(Icons.directions_bus, color: Colors.blue[900]),
              title: const Text('Bus Drivers',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 15.0,
                  )),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BusInfo()));
              },
            ),
            ListTile(
              selectedColor: Colors.grey[400],
              leading: Icon(
                Icons.message,
                color: Colors.blue[900],
              ),
              title: const Text('Messages',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 15.0,
                  )),
              onTap: () {
                Navigator.pushNamed(context, '/messages');
                // Navigator.push(context,MaterialPageRoute(builder: (context) =>const Home()));
              },
            ),
            ListTile(
              selectedColor: Colors.grey[400],
              leading: Icon(
                Icons.person,
                color: Colors.blue[900],
              ),
              title: const Text('Student Files',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 15.0,
                  )),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const StdInfo()));
              },
            ),
            ListTile(
              selectedColor: Colors.grey[400],
              leading: Icon(
                Icons.schedule,
                color: Colors.blue[900],
              ),
              title: const Text('Bus Schedule',
                  style: TextStyle(fontFamily: 'Wellfleet', fontSize: 15.0)),
              onTap: () {
                Navigator.pushNamed(context, '/sched');
                //  Navigator.push(context,MaterialPageRoute(builder: (context) => const Home()));
              },
            ),
            const SizedBox(
              height: 300.0,
            ),
            ListTile(
              title: Row(
                children: [
                  Image.asset(
                    'lib/assets/images/logo.png',
                    width: 84.0,
                    height: 50.0,
                  ),
                  const Text('Employee ID',
                      style:
                      TextStyle(fontFamily: 'Wellfleet', fontSize: 15.0)),
                ],
              ),
              tileColor: Colors.grey[200],
              trailing: Icon(
                Icons.logout_sharp,
                color: Colors.blue[900],
              ),
              onTap: () {
                Navigator.pushNamed(context, '/sched');
                //  Navigator.push(context,MaterialPageRoute(builder: (context) => const Home()));
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