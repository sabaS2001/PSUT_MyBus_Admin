import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_bus_portal/elements/AlertDialogs/editBusStopInfo.dart';
import 'package:my_bus_portal/elements/Drawer.dart';
import 'package:my_bus_portal/pages/login.dart';

class TabarbourBusSchedule extends StatefulWidget {
  const TabarbourBusSchedule({super.key});

  @override
  State<TabarbourBusSchedule> createState() => _TabarbourBusScheduleState();
}

class _TabarbourBusScheduleState extends State<TabarbourBusSchedule> {
  double getScreenHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight;
  }

  CollectionReference users = FirebaseFirestore.instance
      .collection('markers')
      .doc('Tabarbour')
      .collection('Routes3');
  User? user = FirebaseAuth.instance.currentUser;

  double getScreenWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 70.0,
        iconTheme: IconThemeData(color: Colors.blue[900]),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Center(
          child: Image.asset(
            'lib/assets/images/logo.png',
            width: 100.0,
            height: 60.0,
          ),
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
      drawer: const PSUTDrawer(),
      body: StreamBuilder(
        stream: users.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue[900],
                strokeWidth: 3.0,
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(10.0),
                        right: Radius.circular(10.0)),
                    color: Colors.grey[100],
                  ),
                  padding: const EdgeInsets.all(20.0),
                  width: getScreenWidth(context),
                  child: const Row(
                    children: [
                      Text(
                        'Bus Schedule',
                        style: TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: snapshot.data != null
                      ? Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(2),
                    },
                    border: TableBorder(
                      top: BorderSide.lerp(
                          const BorderSide(color: Colors.black),
                          const BorderSide(color: Colors.black),
                          30.0),
                      bottom: BorderSide.lerp(
                          const BorderSide(color: Colors.black),
                          const BorderSide(color: Colors.black),
                          30.0),
                    ),
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(42, 48, 66, 1.0),
                        ),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Name of Bus Stop',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('Arrival Time of Route 1',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              )),
                          TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('Arrival Time of Route 2',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              )),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Bus Number',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Actions',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                      ...snapshot.data!.docs
                          .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                        return TableRow(
                          children: [
                            TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(document.id,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                )),
                            TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(data['arrivaltimeR1'] ?? 'none',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                )),
                            TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(data['arrivaltimeR2'] ?? 'none',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                )),
                            TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(data['busNumber'] ?? 'none',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                )),
                            TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        EditBusStop(),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                            backgroundColor:
                                            WidgetStatePropertyAll(
                                                Colors.red.shade800),
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(Icons.delete,
                                                  color: Colors.white),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                'Delete Bus Stop',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                    'Wellfleet',
                                                    fontSize: 15.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))),
                          ],
                        );
                      }),
                    ],
                  )
                      : const Center(child: CircularProgressIndicator()),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}