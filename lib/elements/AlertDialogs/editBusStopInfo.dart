import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BusStopInfo {
  final String busLine;
  final String docID;
  const BusStopInfo(this.busLine, this.docID);
}

class EditBusStop extends StatefulWidget {
  final String busLine;
  final String docID;
  const EditBusStop({Key? key, required this.busLine, required this.docID}) : super(key: key);
  @override
  State<EditBusStop> createState() => _EditBusStopState();
}

class _EditBusStopState extends State<EditBusStop> {
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController locationLat = TextEditingController();
  final TextEditingController locationLong = TextEditingController();
  final TextEditingController arrivalTimeR1 = TextEditingController();
  final TextEditingController arrivalTimeR2 = TextEditingController();
  final TextEditingController busNumber = TextEditingController();

  late CollectionReference markers;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        switch (widget.busLine) {
          case 'Tabarbour':
            markers = FirebaseFirestore.instance
                .collection('markers')
                .doc('Tabarbour')
                .collection('Routes3');
            break;
          case 'Marj Al Hammam':
            markers = FirebaseFirestore.instance
                .collection('markers')
                .doc('Marj Al Hammam')
                .collection('Routes2');
            break;
          case 'Madinah ':
            markers = FirebaseFirestore.instance
                .collection('markers')
                .doc('Madinah ')
                .collection('Routes');
            break;
          default:
            break;
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
                  return AlertDialog(
                    shadowColor: Colors.blue[900],
                    backgroundColor: Colors.white,
                    title: const Center(
                      child: Text('Bus Stop Information:',
                          style: TextStyle(
                            fontFamily: 'Wellfleet',
                            fontSize: 20.0,
                            color: Colors.black,
                          )),
                    ),
                    content: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 200,
                                height: 40,
                                child: Text('Bus Stop Name:',
                                    style: TextStyle(
                                        fontFamily: 'Wellfleet',
                                        fontSize: 16.0)),
                              ),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: Text(
                                    widget.docID,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontFamily: 'Wellfleet',
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 200,
                                child: Text('Location: ',
                                    style: TextStyle(
                                        fontFamily: 'Wellfleet',
                                        fontSize: 16.0)),
                              ),
                              SizedBox(
                                width: 90,
                                height: 30,
                                child: TextFormField(
                                    controller: locationLat,
                                    decoration: const InputDecoration(
                                      hintText: 'Latitude',
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 10.0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2.0,
                                      )),
                                    ),
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontFamily: 'Wellfleet',
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    )),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              SizedBox(
                                width: 100,
                                height: 30,
                                child: TextFormField(
                                    controller: locationLong,
                                    decoration: const InputDecoration(
                                      hintText: 'Longitude',
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 10.0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2.0,
                                      )),
                                    ),
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontFamily: 'Wellfleet',
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 200,
                                child: Text('Arrival Time (Route 1): ',
                                    style: TextStyle(
                                        fontFamily: 'Wellfleet',
                                        fontSize: 16.0)),
                              ),
                              SizedBox(
                                width: 200,
                                height: 30,
                                child: TextFormField(
                                    controller: arrivalTimeR1,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 10.0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2.0,
                                      )),
                                    ),
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontFamily: 'Wellfleet',
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 200,
                                child: Text('Arrival Time (Route 2): ',
                                    style: TextStyle(
                                        fontFamily: 'Wellfleet',
                                        fontSize: 16.0)),
                              ),
                              SizedBox(
                                width: 200,
                                height: 30,
                                child: TextFormField(
                                    controller: arrivalTimeR2,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 10.0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2.0,
                                      )),
                                    ),
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontFamily: 'Wellfleet',
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 200,
                                child: Text('Bus Number:',
                                    style: TextStyle(
                                        fontFamily: 'Wellfleet',
                                        fontSize: 16.0)),
                              ),
                              SizedBox(
                                width: 200,
                                height: 30,
                                child: TextFormField(
                                    controller: busNumber,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 10.0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2.0,
                                      )),
                                    ),
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontFamily: 'Wellfleet',
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () async {
                          await markers.doc(widget.docID).update({
                            'busNumber': busNumber.text,
                            'arrivaltimeR1': arrivalTimeR1.text,
                            'arrivaltimeR2': arrivalTimeR2.text,
                             'location': GeoPoint(double.parse(locationLat.text), double.parse(locationLong.text))
                          });
                          await FirebaseFirestore.instance.collection('markersAdmin').doc(widget.docID).update({
                            'location': GeoPoint(double.parse(locationLat.text), double.parse(locationLong.text))
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(11, 39, 143, 1.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                        ),
                        child: const Text('SAVE',
                            style: TextStyle(
                              fontFamily: 'Wellfleet',
                              fontSize: 15.0,
                              color: Colors.white,
                            )),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(11, 39, 143, 1.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                        ),
                        child: const Text('CANCEL',
                            style: TextStyle(
                              fontFamily: 'Wellfleet',
                              fontSize: 15.0,
                              color: Colors.white,
                            )),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
      },
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.blue.shade900),
      ),
      child: const Row(
        children: [
          Icon(Icons.edit, color: Colors.white),
          SizedBox(
            width: 10.0,
          ),
          Text(
            'Edit Bus Stop',
            style: TextStyle(
                color: Colors.white, fontFamily: 'Wellfleet', fontSize: 15.0),
          ),
        ],
      ),
    );
  }
}
