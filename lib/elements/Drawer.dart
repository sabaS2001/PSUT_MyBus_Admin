import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_bus_portal/elements/AlertDialogs/ShowChangedPassword.dart';
import 'package:my_bus_portal/pages/MadinahBusSchedule.dart';
import 'package:my_bus_portal/pages/MarjBusSchedule.dart';
import 'package:my_bus_portal/pages/TabarbourBusSchedule.dart';
import 'package:my_bus_portal/pages/busInfo.dart';
import 'package:my_bus_portal/pages/chat.dart';
import 'package:my_bus_portal/pages/home.dart';
import 'package:my_bus_portal/pages/login.dart';
import 'package:my_bus_portal/pages/stdinfo.dart';

class PSUTDrawer extends StatefulWidget {
  const PSUTDrawer({super.key});

  @override
  State<PSUTDrawer> createState() => _PSUTDrawerState();
}

class _PSUTDrawerState extends State<PSUTDrawer> {
  User? user = FirebaseAuth.instance.currentUser;

  double getScreenHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight;
  }

  double getScreenWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              Navigator.push(context,MaterialPageRoute(builder: (context) => AdminChat(email: user!.email.toString(),)));
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
          ExpansionTile(
            leading: Icon(
              Icons.schedule,
              color: Colors.blue[900],
            ),
            title: const Text('Bus Schedule',
                style: TextStyle(fontFamily: 'Wellfleet', fontSize: 15.0)),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  selectedColor: Colors.grey[400],
                  leading: Icon(
                    Icons.timeline_sharp,
                    color: Colors.blue[900],
                  ),
                  title: const Text('Marj Hammam',
                      style: TextStyle(
                        fontFamily: 'Wellfleet',
                        fontSize: 14.0,
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MarjBusSchedule()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  selectedColor: Colors.grey[400],
                  leading: Icon(
                    Icons.timeline_sharp,
                    color: Colors.blue[900],
                  ),
                  title: const Text('Madinah',
                      style: TextStyle(
                        fontFamily: 'Wellfleet',
                        fontSize: 14.0,
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MadinahBusSchedule()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListTile(
                  selectedColor: Colors.grey[400],
                  leading: Icon(
                    Icons.timeline_sharp,
                    color: Colors.blue[900],
                  ),
                  title: const Text('Tabarbour',
                      style: TextStyle(
                        fontFamily: 'Wellfleet',
                        fontSize: 14.0,
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TabarbourBusSchedule()));
                  },
                ),
              ),
            ],
          ),
          Container(
            color: Colors.grey[200],
            margin: EdgeInsets.fromLTRB(
                0.0,
                (getScreenHeight(context) - getScreenHeight(context) * 0.85),
                0.0,
                0.0),
            alignment: Alignment.bottomRight,
            child: ListTile(
              title: Row(
                children: [
                  Text( user!.email.toString(),
                      style:
                          const TextStyle(fontFamily: 'Wellfleet', fontSize: 14.0)),
                ],
              ),
              trailing: Icon(
                Icons.logout_sharp,
                color: Colors.blue[900],
              ),
              tileColor: Colors.grey[200],
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ),
          ListTile(
              title: const Text('Change Password',
                  style:
                      TextStyle(fontFamily: 'Wellfleet', fontSize: 14.0)),
              trailing:  Icon(
                Icons.lock_person,
                color: Colors.blue[900],
              ),
              onTap: () async {
                ChangePassword().showChangedPassword(context);
              }),
        ],
      ),
    );
  }
}
