import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_bus_portal/elements/BusDriverValidation.dart';
import 'package:my_bus_portal/pages/FireAuth.dart';


class AddBusDriver with InputValidationBusDriversMixin {

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
          return SizedBox(
            width: getScreenWidth(context) - getScreenWidth(context)*.50,
            child: AlertDialog(
              shadowColor: Colors.blue[900],
              backgroundColor: Colors.white,
              title: const Center(
                child: Text('Bus Driver Info:',
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
                                  validator: (fName) {
                                    if (isNameValid(fName!)) {
                                      return null;
                                    } else {
                                      return 'Invalid First Name!';
                                    }
                                  },
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
                                  validator: (lName) {
                                    if (isNameValid(lName!)) {
                                      return null;
                                    } else {
                                      return 'Invalid Last Name!';
                                    }
                                  },
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
                                  validator: (empID) {
                                    if (isIDValid(empID!)) {
                                      return null;
                                    } else {
                                      return 'Invalid Employee ID!';
                                    }
                                  },
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
                                  validator: (email) {
                                    if (isEmailValid(email!)) {
                                      return null;
                                    } else {
                                      return 'Invalid Employee Email!';
                                    }
                                  },
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
                                  validator: (phoneNum) {
                                    if (isPhoneNumberValid(phoneNum!)) {
                                      return null;
                                    } else {
                                      return 'Invalid Phone Number! Must start with 962';
                                    }
                                  },
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
                                  validator: (busNumber) {
                                    if (isBusNumberValid(busNumber!)) {
                                      return null;
                                    } else {
                                      return 'Invalid Bus Number!';
                                    }
                                  },
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
                                  validator: (busLine) {
                                    if (isBusLineValid(busLine!)) {
                                      return null;
                                    } else {
                                      return 'Invalid Bus Line!';
                                    }
                                  },
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
                                  validator: (password) {
                                    if (isPasswordValid(password!)) {
                                      return null;
                                    } else {
                                      return 'Invalid Password!';
                                    }
                                  },
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
                                  validator: (confirmedpassword) {
                                    if (isPasswordValid(confirmedpassword!)) {
                                      return null;
                                    } else {
                                      return 'Invalid Password!';
                                    }
                                  },
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
                      if(_confirmedpassword.text == _password.text) {
                        if(_formKey.currentState!.validate()){
                          User? user = await FireAuth
                              .registerThroughEmail(
                            email: _email.text,
                            password: _password.text,
                          );
                          if(user != null) {
                            FirebaseFirestore.instance.collection('drivers').doc(user.uid).set({
                              'firstName': _firstName.text,
                              'lastName': _lastName.text,
                              'email': _email.text,
                              'empID': _empID.text,
                              'password': _password.text,
                              'busLine': _busLine.text,
                              'busNumber': _busNumber.text,
                              'phoneNumber': _phoneNumber.text,
                            });
                          }
                          Navigator.pop(context);
                        }

                      }

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
