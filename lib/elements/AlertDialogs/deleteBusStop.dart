import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class BusStopInfo {
  final String busLine;
  final String docID;
  const BusStopInfo(this.busLine, this.docID);
}

class DeleteBusStop extends StatefulWidget {
  final String busLine;
  final String docID;
  const DeleteBusStop({super.key, required this.busLine, required this.docID});
  @override
  _DeleteBusStopState createState() => _DeleteBusStopState();
}

class _DeleteBusStopState extends State<DeleteBusStop> {
  User? user = FirebaseAuth.instance.currentUser;
  late CollectionReference markers;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
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
          builder:
              (BuildContext context) {
            return AlertDialog(
              shadowColor:
              Colors.blue[900],
              backgroundColor:
              Colors.white,
              title: const Center(
                child: Text(
                    'Delete Bus Stop',
                    style: TextStyle(
                      fontFamily:
                      'Wellfleet',
                      fontSize: 20.0,
                      color: Colors
                          .black,
                    )),
              ),
              content: const Text('This bus stop will be deleted!',
                  style: TextStyle(
                      fontFamily:
                      'Wellfleet',
                      fontSize:
                      16.0)),
              actions: <Widget>[
                ElevatedButton(
                  onPressed:
                      () async {
                        await markers.doc(widget.docID)
                            .delete()
                            .then(
                              (doc) => print(
                              "Document deleted"),
                          onError: (e) =>
                              print(
                                  "Error updating document $e"),
                        );
                        Navigator.of(context)
                            .pop();

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                  ),
                  child: const Text(
                      'OK',
                      style:
                      TextStyle(
                        fontFamily:
                        'Wellfleet',
                        fontSize:
                        15.0,
                        color: Colors
                            .white,
                      )),),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                  ),
                  child: const Text(
                      'CANCEL',
                      style:
                      TextStyle(
                        fontFamily:
                        'Wellfleet',
                        fontSize:
                        15.0,
                        color: Colors
                            .white,
                      )),
                  onPressed: () {
                    Navigator.of(
                        context)
                        .pop();
                  },
                ),
              ],
            );
          },
        );
      },
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
    );
  }
}