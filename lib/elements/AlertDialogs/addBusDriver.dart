import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AddBusDriver {

  double getScreenWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }

  CollectionReference users = FirebaseFirestore.instance.collection('drivers');
  User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController _busLine = TextEditingController();
  final TextEditingController _busNumber = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _empID = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmedpassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  Future addBusDriver(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: getScreenWidth(context) - getScreenWidth(context)*.50,
            child: AlertDialog(
              shadowColor: Colors.blue[900],
              backgroundColor: Colors.white,
              title: const Center(
                child: Text('Change Password',
                    style: TextStyle(
                      fontFamily: 'Wellfleet',
                      fontSize: 20.0,
                      color: Colors.black,
                    )),
              ),
              content: StreamBuilder(
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
                  return Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20.0),
                            child: const CircleAvatar(
                              radius: 100.0,
                              backgroundColor: Colors.yellow,
                            ),
                          ),
                          //First Name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 150,
                                child: Text(
                                  "First Name: ",
                                  style: TextStyle(
                                    fontFamily: 'Wellfleet',
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0.0, 10.0),
                                width: 400,
                                child: TextFormField(
                                  controller: _firstName,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //Last Name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 150,
                                child: Text(
                                  "Last Name: ",
                                  style: TextStyle(
                                    fontFamily: 'Wellfleet',
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0.0, 10.0),
                                width: 400,
                                child: TextFormField(
                                  controller: _lastName,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //Employee ID
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 150,
                                child: Text(
                                  "Employee ID: ",
                                  style: TextStyle(
                                    fontFamily: 'Wellfleet',
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0.0, 10.0),
                                width: 400,
                                child: TextFormField(
                                  controller: _empID,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //Employee Email
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 150,
                                child: Text(
                                  "Employee Email: ",
                                  style: TextStyle(
                                    fontFamily: 'Wellfleet',
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0.0, 10.0),
                                width: 400,
                                child: TextFormField(
                                  controller: _email,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //Phone Number
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 150,
                                child: Text(
                                  "Phone Number: ",
                                  style: TextStyle(
                                    fontFamily: 'Wellfleet',
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0.0, 10.0),
                                width: 400,
                                child: TextFormField(
                                  controller: _phoneNumber,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //Bus Number
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 150,
                                child: Text(
                                  "Bus Number: ",
                                  style: TextStyle(
                                    fontFamily: 'Wellfleet',
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0.0, 10.0),
                                width: 400,
                                child: TextFormField(
                                  controller: _busNumber,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //Bus Line
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 150,
                                child: Text(
                                  "Bus Line: ",
                                  style: TextStyle(
                                    fontFamily: 'Wellfleet',
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0.0, 10.0),
                                width: 400,
                                child: TextFormField(
                                  controller: _busLine,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 150,
                                child: Text(
                                  "Password: ",
                                  style: TextStyle(
                                    fontFamily: 'Wellfleet',
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0.0, 10.0),
                                width: 400,
                                child: TextFormField(
                                  controller: _password,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //Confirmed Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 150,
                                child: Text(
                                  "Confirmed Password: ",
                                  style: TextStyle(
                                    fontFamily: 'Wellfleet',
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0.0, 10.0),
                                width: 400,
                                child: TextFormField(
                                  controller: _confirmedpassword,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () async {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                    ),
                    child: const Text(
                      'Add Bus Driver',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Wellfleet',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    )),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Wellfleet',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          );
        });
  }
}
