import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

int index = 0;

class driverMaps extends StatefulWidget {
  const driverMaps({super.key});

  @override
  State<driverMaps> createState() => _driverMapsState();
}

class _driverMapsState extends State<driverMaps> {
  late GoogleMapController mapController;
  final Completer <GoogleMapController> _controller = Completer();
  List<Marker> markers = []; // Use a Set to avoid duplicate markers
  CollectionReference users = FirebaseFirestore.instance.collection('drivers');
  User? user = FirebaseAuth.instance.currentUser;
  late CollectionReference<Object?>? busScheduleCollection = FirebaseFirestore
      .instance
      .collection('markers')
      .doc('Tabarbour')
      .collection('Routes'); // return null if the document does not exist;
  String busLine = '';
  String busNumber = '';
  String name = '';

  late Stream<QuerySnapshot> _driversStream;
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


  // Assigning the markers based on the bus line the admin assigned
  Future<CollectionReference<Object?>?> readData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('drivers')
        .doc('s7aGRbtu2aeipDkABZFexVgffSV2')
        .get();
    if (documentSnapshot.exists) {
      busLine = documentSnapshot.get('busLine');
      busNumber = documentSnapshot.get('busNumber');
      name = documentSnapshot.get('firstName');
      debugPrint(busLine);
      if (busLine == 'Marj Al Hammam') {
        return FirebaseFirestore.instance
            .collection('markers')
            .doc('Marj Al Hammam')
            .collection('Routes2');
      } else if (busLine == 'Madinah ') {
        return FirebaseFirestore.instance
            .collection('markers')
            .doc('Madinah ')
            .collection('Routes');
      }
    } else {
      debugPrint('Document does not exist');
    }
    return null;
  }

  Future<void> _initBusScheduleCollection() async {
    busScheduleCollection = await readData();
    setState(() {});
  }

//------------------------------ Making the Lines between 2 Markers ---------------------
  //Polylines; connect a line between 2 markers
  List<LatLng> polylineCoordinates = [];
  void getPolyPoints(sourceLocation, destinationLocation) async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyB6fVHZJJyDZUc4DNSreEZUy6tacqEqeQ0',
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        // print(polylineCoordinates);
      }
    }
  }

  @override
  void initState() {
    _initBusScheduleCollection();
    super.initState();
    _driversStream = FirebaseFirestore.instance.collection('drivers').snapshots();
    _listenToDriversStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           Row(
             children: [
               Icon(Icons.directions_bus,
               color: Colors.blue[900],
               size: 35,),
               Text( 'Bus Number: $busLine',
               style: const TextStyle(
                 fontSize: 17.0,
                 fontFamily: 'Wellfleet',
                 color: Colors.black
               ),)
             ],
           ),
          Row(
            children: [
              Icon(Icons.person,
                color: Colors.blue[900],
                size: 35,),
              Text( 'Bus Driver Name: $name',
                style: const TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'Wellfleet',
                    color: Colors.black
                ),)
            ],
          ),
          Row(
            children: [
              Icon(Icons.map_outlined,
                color: Colors.blue[900],
                size: 35,),
              Text( 'Bus Line: $busLine',
                style: const TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'Wellfleet',
                    color: Colors.black
                ),)
            ],
          )
        ],),
      ),
      body: StreamBuilder(
        //Get all the routes that's available in Madinah called Routes
        stream: busScheduleCollection!.orderBy('number', descending: false).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue[900],
                strokeWidth: 3.0,
              ),
            );
          }
          markers.clear();
          for (var element in snapshot.data!.docs) {
            //For each document in the routes, retrieve their data
            final data = element.data();
            if ((data as Map<String, dynamic>)['location']?.latitude !=
                null) {
              // the marker id is the document title exists in the firestore
              final MarkerId markerId = MarkerId(element.id.toString());
              final Marker marker = Marker(
                markerId: markerId,
                //retrieve each marker's latitude and longitude from firestore
                position: LatLng(data['location']?.latitude,
                    data['location']?.longitude),
                //display the marker title
                infoWindow: InfoWindow(title: element.id.toString()),
              );
              markers.add(marker);
              polylineCoordinates.add(
                  LatLng(marker.position.latitude, marker.position.longitude));
            }
          }
          return Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                myLocationEnabled: true,
                initialCameraPosition: const CameraPosition(
                    target: LatLng(32.023757505069405, 35.876136445246374), zoom: 13),
                onMapCreated: (mapController){
                  _controller.complete(mapController);
                },
                markers: markers.toSet(),
                polylines: {
                  Polyline(
                      polylineId: const PolylineId('route'),
                      points: polylineCoordinates,
                      color: const Color.fromRGBO(0, 169, 224, 1.0))
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
