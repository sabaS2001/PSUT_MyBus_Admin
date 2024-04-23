import 'package:flutter/material.dart';
import 'pages/login.dart'; // Fix import path
import 'pages/dash.dart'; // Fix import path
import 'pages/login.dart'; // Fix import path
import 'pages/busInfo.dart'; // Fix import path
import 'pages/stdinfo.dart'; // Fix import path
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Add named 'key' parameter

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Bus Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StdInfo(), // Set StdInfoPage as the home page
    );
  }
}