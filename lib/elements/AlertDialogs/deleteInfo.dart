import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Info {
  final String collectionName;
  final String docID;
  const Info(this.collectionName, this.docID);
}
 class DeleteInfo extends StatefulWidget {
   final String collectionName;
   final String docID;
   const DeleteInfo({super.key, required this.collectionName, required this.docID});

   @override
   State<DeleteInfo> createState() => _DeleteInfoState();
 }

 class _DeleteInfoState extends State<DeleteInfo> {
   @override
   Widget build(BuildContext context) {
     return ElevatedButton(
       onPressed: () {
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
                     'Delete Account!',
                     style: TextStyle(
                       fontFamily:
                       'Wellfleet',
                       fontSize: 20.0,
                       color: Colors.black,
                     )),
               ),
               content: const Text(
                   'Are you sure to delete this account!',
                   textAlign:
                   TextAlign.justify,
                   style: TextStyle(
                     fontFamily:
                     'Wellfleet',
                     fontSize: 16.0,
                     color: Colors.black,
                   )),
               actions: <Widget>[
                 ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     backgroundColor:
                     const Color.fromRGBO(11, 39, 143, 1.0),
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(40.0)),
                   ),
                   child: const Text('OK',
                       style: TextStyle(
                         fontFamily:
                         'Wellfleet',
                         fontSize: 15.0,
                         color:
                         Colors.white,
                       )),
                   onPressed: () {
                     FirebaseFirestore
                         .instance
                         .collection(
                         widget.collectionName)
                         .doc(widget.docID)
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
                 ),
                 ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     backgroundColor:
                     const Color.fromRGBO(11, 39, 143, 1.0),
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(40.0)),
                   ),
                   child: const Text(
                       'CANCEL',
                       style: TextStyle(
                         fontFamily:
                         'Wellfleet',
                         fontSize: 15.0,
                         color:
                         Colors.white,
                       )),
                   onPressed: () {
                     Navigator.of(context)
                         .pop();
                   },
                 ),
               ],
             );
           },
         );
       },
       style: ElevatedButton.styleFrom(
           backgroundColor:
           Colors.red[900]),
       child: const Row(
         crossAxisAlignment:
         CrossAxisAlignment.center,
         children: [
           Icon(
             Icons.delete_sharp,
             color: Colors.white,
           ),
           SizedBox(
             width: 8.0,
           ),
           Text(
             'Delete',
             style: TextStyle(
               fontSize: 15.0,
               fontFamily: 'Wellfleet',
               color: Colors.white,
             ),
           ),
         ],
       ),
     );
   }
 }
