import 'package:flutter/material.dart';

class Showchangedpassword extends StatefulWidget {
  const Showchangedpassword({super.key});

  @override
  State<Showchangedpassword> createState() => _ShowchangedpasswordState();
}

class _ShowchangedpasswordState extends State<Showchangedpassword> {
  @override
  Widget build(BuildContext context) {
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
  }
}

