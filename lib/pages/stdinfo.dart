import 'package:flutter/material.dart';

import 'busInfo.dart';
import 'home.dart';

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
          iconTheme: IconThemeData(color: Colors.blue[900]),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Image.asset(
            'lib/assets/images/logo.png',
            width: 84.0,
            height: 50.0,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.blue[900],
              ),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
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
