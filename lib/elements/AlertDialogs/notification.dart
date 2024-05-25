import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmergencyNotification {
  Stream<QuerySnapshot<Object?>> notify = FirebaseFirestore.instance
      .collection('Notifications')
      .snapshots();

  User? user = FirebaseAuth.instance.currentUser;

  Future notificationAdmin(BuildContext context) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Center(
              child: Text('Notifications',
                style: TextStyle(
                    fontFamily: 'Wellfleet'
                ),),
            ),
            content: SingleChildScrollView(
              child: Container(
                width: MediaQuery.sizeOf(context).width * .30,
                margin: const EdgeInsets.all(5),
                child: StreamBuilder<QuerySnapshot>(
                    stream: notify,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                          return Column(
                            children: snapshot.data!.docs.map((doc) {
                              Map<String, dynamic> data =
                              doc.data() as Map<String, dynamic>;
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.wrong_location_sharp,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width * .20,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Emergency Notification',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: 'Wellfleet'),
                                        ),
                                        Text(
                                          data['message'],
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: 'Wellfleet',
                                              color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: Text(
                                      DateFormat.yMd()
                                          .format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              data['time']
                                                  .millisecondsSinceEpoch))
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'Wellfleet',
                                          color: Colors.grey.shade600),
                                    ),
                                  )
                                ],
                              );
                            }).toList(),
                          );
                        }
                        return Container(
                          margin: const EdgeInsets.fromLTRB(20,90,20,20),
                          height: MediaQuery.sizeOf(context).height - MediaQuery.sizeOf(context).height*.20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.mark_unread_chat_alt_sharp,
                                color: Colors.blue.shade900,
                                size: 70,),
                              const Text('No Notifcations',
                                style: TextStyle(
                                    fontFamily: 'WellFleet',
                                    fontSize: 16.0
                                ),),
                              const Text('We’ll let you know when there will be something to update you.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Wellfleet',
                                    fontSize: 16.0
                                ),)
                            ],
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Center(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(
                              strokeWidth: 4.0,
                              color: Colors.blue[900],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue.shade900)
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close',
                  style: TextStyle(
                      fontFamily: 'Wellfleet',
                      color: Colors.white
                  ),),
              ),
            ],
          );
        },
      );
  }
}
