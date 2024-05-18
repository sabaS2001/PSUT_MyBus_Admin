import 'package:firebase_auth/firebase_auth.dart';
import  'package:flutter/material.dart';
import 'package:my_bus_portal/pages/login.dart';

class ForgetPassword{
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //regression expression for admin email
  bool isEmailValid(String email) {
    const pattern = r'^[a-zA-Z]{3}\d{8}@psut.edu.jo$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  Future ForgetPasswordDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shadowColor: Colors.blue[900],
            backgroundColor: Colors.white,
            title: const Center(
              child: Text('Forget Password',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 20.0,
                    color: Colors.black,
                  )),
            ),
            content: Form(
              key: _formKey,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width - MediaQuery.sizeOf(context).width * .75,
                height:MediaQuery.sizeOf(context).height -MediaQuery.sizeOf(context).height *.90 ,
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
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: _emailController.text.trim());
                        _showAlertDialog(context);
                        MaterialPageRoute(builder: (context) => const LoginPage());
                      } on FirebaseAuthException catch (e) {
                        throw Exception(e.message.toString());
                      } catch (e) {
                        throw Exception(e.toString());
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                  ),
                  child: const Text(
                    'Forget Password',
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
void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: Colors.blue[900],
        backgroundColor: Colors.white,
        title: const Center(
          child:  Text('Forget Password',
              style: TextStyle(
                fontFamily: 'Wellfleet',
                fontSize: 20.0,
                color: Colors.black,
              )),
        ),
        content: const Text('Please Check Your Email to Reset Your Password!',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'Wellfleet',
              fontSize: 16.0,
              color: Colors.black,
            )),
        actions:  <Widget>[
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(11, 39, 143, 1.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
              ),
              child: const Text('OK',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 15.0,
                    color: Colors.white,
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