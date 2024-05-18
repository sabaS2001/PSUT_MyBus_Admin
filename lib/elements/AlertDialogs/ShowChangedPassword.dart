import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_bus_portal/pages/FireAuth.dart';

class ChangePassword {
  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future showChangedPassword(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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
            content: Form(
              key: _formKey,
              child: SizedBox(
                width: getScreenWidth(context) - getScreenWidth(context) * .75,
                height:MediaQuery.sizeOf(context).height -MediaQuery.sizeOf(context).height *.65 ,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: (psEmail) {
                        if (isEmailValid(psEmail!)) {
                          return null;
                        } else {
                          return 'Invalid Email!';
                        }
                      },
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 12.0,
                            fontFamily: 'Wellfleet',
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                              10.0, 0.0, 15.0, 0.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.black)),
                          labelText: "Admin Email:",
                          labelStyle: const TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _oldPassword,
                      validator: (psPassword) {
                        if (isPasswordValid(psPassword!)) {
                          return null;
                        } else {
                          return 'Invalid Current Password!';
                        }
                      },
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 12.0,
                            fontFamily: 'Wellfleet',
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                              10.0, 0.0, 15.0, 0.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.black)),
                          labelText: "Current Password:",
                          labelStyle: const TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: getScreenWidth(context) *
                          getScreenWidth(context) *
                          .75,
                      child: const Text(
                          'The new password must be different from the current password',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Wellfleet'
                        ) ,),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _newPassword,
                      validator: (psPassword) {
                        if (isPasswordValid(psPassword!)) {
                          return null;
                        } else {
                          return 'Invalid New Password!';
                        }
                      },
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 12.0,
                            fontFamily: 'Wellfleet',
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                              10.0, 0.0, 15.0, 0.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.black)),
                          labelText: "New Password:",
                          labelStyle: const TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Wellfleet',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        User? user = (await FireAuth.changePassword(
                          currentPassword: _oldPassword.text,
                          newPassword: _newPassword.text,
                          email: _emailController.text,
                        ));
                        _showChangedPasswordDialog(context);
                      } on FirebaseAuthException catch (e) {
                        print(e);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                  ),
                  child: const Text(
                    'Change Password',
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
          );
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
          child: Text('Password Changed!',
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
        actions: <Widget>[
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

//Regression Expression for Admin Email and Password
bool isEmailValid(String email) {
  const pattern = r'^[a-zA-Z]{3}\d{8}@psut.edu.jo$';
  RegExp regex = RegExp(pattern.toString());
  return regex.hasMatch(email);
}

bool isPasswordValid(String password) {
  if (password.length == 8) {
    return true;
  } else {
    return false;
  }
}

double getScreenWidth(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth;
}
