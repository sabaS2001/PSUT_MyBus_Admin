import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_bus_portal/pages/MadinahBusSchedule.dart';
import 'package:my_bus_portal/pages/home.dart';
import 'package:my_bus_portal/pages/sched.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'My Bus Portal',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home:  const BusSchedule(), // Set StdInfoPage as the home page
  ));
}
