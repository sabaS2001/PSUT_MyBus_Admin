import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_bus_portal/elements/AlertDialogs/notification.dart';
import 'package:my_bus_portal/elements/Drawer.dart';
import 'messages.dart';

class AdminChat extends StatefulWidget {
  String email;
  AdminChat({super.key, required this.email});

  @override
  _AdminChatState createState() => _AdminChatState(email: email);
}

class _AdminChatState extends State<AdminChat> {
  String email;
  _AdminChatState({required this.email});

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      drawer: const PSUTDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.79,
                child: Messages(
                  email: email,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: 'Wellfleet'),
                      controller: message,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue[900],
                        hintText: 'Message',
                        hintStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'Wellfleet'),
                        enabled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        message.text = value!;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (message.text.isNotEmpty) {
                        _firestore.collection('Messages').doc().set({
                          'message': message.text.trim(),
                          'time': DateTime.now(),
                          'email': email,
                        });

                        message.clear();
                      }
                    },
                    icon: Icon(
                      Icons.send_sharp,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
