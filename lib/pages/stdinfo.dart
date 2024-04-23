import 'package:flutter/material.dart';
import 'login.dart';

class StdInfo extends StatefulWidget {
  const StdInfo({super.key});

  @override
  _StdInfoState createState() => _StdInfoState();
}

class _StdInfoState extends State<StdInfo> {
  List<Student> students = [];

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
                students.add(Student());
              });
            },
            child: const Text('Add Student'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('${index + 1}'),
                  title: Text(students[index].name),
                  subtitle: Text(students[index].busNumber),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              String newName = students[index].name;
                              String newBusNumber = students[index].busNumber;
                              return AlertDialog(
                                title: const Text('Edit Student'),
                                content: Column(
                                  children: [
                                    TextField(
                                      onChanged: (value) {
                                        newName = value;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Name',
                                      ),
                                    ),
                                    TextField(
                                      onChanged: (value) {
                                        newBusNumber = value;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Bus Number',
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        students[index].name = newName;
                                        students[index].busNumber = newBusNumber;
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
                            students.removeAt(index);
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
          // Logout 
          Navigator.pushNamed(context, 'lib/pages/login.dart');
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}

class Student {
  String name = 'Student Name';
  String busNumber = 'Bus Number';
}
