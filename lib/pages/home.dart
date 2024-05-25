import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_bus_portal/elements/AlertDialogs/notification.dart';
import 'package:my_bus_portal/elements/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_bus_portal/pages/driverMaps.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Stream<QuerySnapshot<Object?>> notify = FirebaseFirestore.instance
      .collection('Notifications')
      .snapshots();


  double getScreenHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight;
  }
  User? user = FirebaseAuth.instance.currentUser;
  late Stream<QuerySnapshot> _driversStream;


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
    _driversStream = FirebaseFirestore.instance.collection('drivers').snapshots();
    _listenToDriversStream();
  }

  void _listenToDriversStream() {
    _driversStream.listen((querySnapshot) {
      setState(() {
        markers.clear(); // Clear the markers set
        for (var doc in querySnapshot.docs) {
          double lat = doc.get('latitude');
          double long = doc.get('longitude');
          double latitude = lat;
          double longitude = long;
          markers.add(
            Marker(
              infoWindow: const InfoWindow(title: 'Bus Driver'),
              markerId: const MarkerId('currentLocation'),
              position: LatLng(latitude, longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const driverMaps()),
                );
              }
            ),
          );
        }
      });
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
              EmergencyNotification().notificationAdmin(context);
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
      drawer: const PSUTDrawer(),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}