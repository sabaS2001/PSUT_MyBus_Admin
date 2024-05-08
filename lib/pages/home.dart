import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'busInfo.dart';
import 'login.dart';
import 'stdinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  double getScreenHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight;
  }
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is not signed in');
      } else {
        print('User is signed in: ${user.email}');
      }
    });
  }


  late GoogleMapController mapController;
  static const CameraPosition _initialLocation = CameraPosition(
      target: LatLng(32.02363463930013, 35.87613106096076), zoom: 13);

  Set<Marker> markers = {}; // Use a Set to avoid duplicate markers
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: StreamBuilder(
        //Get all the routes that's available in Madinah called Routes
        stream: FirebaseFirestore.instance
            .collectionGroup('markersAdmin')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child: CircularProgressIndicator(
                color: Colors.blue[900],
                strokeWidth: 5.0,
              )),
            );
          } else {
            for (var element in snapshot.data!.docs) {
              //For each document in the routes, retrieve their data
              final data = element.data();
              if (data['location'] != null) {
                // the marker id is the document title exists in the firestore
                final MarkerId markerId = MarkerId(element.id.toString());
                final Marker marker = Marker(
                  markerId: markerId,
                  //retrieve each marker's latitude and longitude from firestore
                  position: LatLng(
                      data['location'].latitude, data['location'].longitude),
                  //display the marker title
                  infoWindow: InfoWindow(title: element.id.toString()),
                );
                markers.add(marker);
              }
            }
            return GoogleMap(
              mapToolbarEnabled: false,
              initialCameraPosition: _initialLocation,
              onMapCreated: _onMapCreated,
              markers: markers,
            );
          }
        },
      ),
      drawer: SizedBox(
        height: getScreenHeight(context),
        child: Drawer(
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
              // const SizedBox(
              //   height: 400.0,
              // ),
              Container(
                color: Colors.grey[200],
                margin: EdgeInsets.fromLTRB(0.0, (getScreenHeight(context)- getScreenHeight(context)*0.75), 0.0, 0.0),
                alignment: Alignment.bottomRight,
                child: ListTile(
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
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     const Text('Change Password',
                        style:
                        TextStyle(fontFamily: 'Wellfleet', fontSize: 15.0)),
                    Icon(
                      Icons.lock_person,
                      color: Colors.blue[900],
                    ),
                  ],
                ),
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: '${user!.email}');
                    _showChangedPasswordDialog(context);
                  } on FirebaseAuthException catch (e) {
                    throw Exception(e.message.toString());
                  } catch (e) {
                    throw Exception(e.toString());
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
void _showChangedPasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: Colors.blue[900],
        backgroundColor: Colors.white,
        title: const Center(
          child:  Text('Password Changed!',
              style: TextStyle(
                fontFamily: 'Wellfleet',
                fontSize: 20.0,
                color: Colors.black,
              )),
        ),
        content: const Text('The Password have changed!',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'Wellfleet',
              fontSize: 16.0,
              color: Colors.black,
            )),
        actions:  <Widget>[
          Center(
            child: ElevatedButton(
              child: const Text('OK',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 15.0,
                    color: Colors.black,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}