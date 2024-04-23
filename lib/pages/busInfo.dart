import 'package:flutter/material.dart';

class BusInfo extends StatefulWidget {
  const BusInfo({super.key});

  @override
  _BusInfoState createState() => _BusInfoState();
}

class _BusInfoState extends State<BusInfo> {
  List<BusDriver> busDrivers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Info'),
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
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                busDrivers.add(BusDriver());
              });
            },
            child: const Text('Add Bus Driver'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: busDrivers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('${index + 1}'),
                  title: Text(busDrivers[index].route),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              String newRoute = busDrivers[index].route;
                              return AlertDialog(
                                title: const Text('Edit Bus Driver'),
                                content: Column(
                                  children: [
                                    TextField(
                                      onChanged: (value) {
                                        newRoute = value;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Bus Route',
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        busDrivers[index].route = newRoute;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            busDrivers.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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

class BusDriver {
  String route = 'Bus Route';
}
