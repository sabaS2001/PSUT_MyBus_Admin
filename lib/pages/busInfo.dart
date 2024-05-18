import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_bus_portal/elements/Drawer.dart';
import 'package:my_bus_portal/elements/AlertDialogs/addBusDriver.dart';
import 'package:my_bus_portal/pages/stdinfo.dart';
import 'home.dart';
import 'login.dart';

class BusInfo extends StatefulWidget {
  const BusInfo({super.key});

  @override
  _BusInfoState createState() => _BusInfoState();
}

class _BusInfoState extends State<BusInfo> {
  final TextEditingController _busLine = TextEditingController();
  final TextEditingController _busNumber = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _empID = TextEditingController();

  double getScreenHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight;
  }

  CollectionReference users = FirebaseFirestore.instance.collection('drivers');
  User? user = FirebaseAuth.instance.currentUser;

  double getScreenWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }

  @override
  void dispose (){
    _busNumber.dispose();
    _phoneNumber.dispose();
    _empID.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _busLine.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Notifications'),
                    content: const Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.notification_important),
                          title: Text('Notification 1'),
                        ),
                        ListTile(
                          leading: Icon(Icons.notification_important),
                          title: Text('Notification 2'),
                        ),
                        ListTile(
                          leading: Icon(Icons.notification_important),
                          title: Text('Notification 3'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      drawer: const PSUTDrawer(),
      body: StreamBuilder(
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
          return Container(
            margin: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(10.0),
                        right: Radius.circular(10.0)),
                    color: Colors.grey[100],
                  ),
                  padding: const EdgeInsets.all(20.0),
                  width: getScreenWidth(context),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Bus Drivers',
                        style: TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                              AddBusDriver().addBusDriver(context);
                      },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                          ),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(Icons.add, color: Colors.white,),
                              ),
                              Text('Add New Bus Driver ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  child: snapshot.data != null
                      ? Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1),
                      5: FlexColumnWidth(3.5),
                    },
                    border: TableBorder(
                      top: BorderSide.lerp(
                          const BorderSide(color: Colors.black),
                          const BorderSide(color: Colors.black),
                          30.0),
                      bottom: BorderSide.lerp(
                          const BorderSide(color: Colors.black),
                          const BorderSide(color: Colors.black),
                          30.0),
                    ),
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(42, 48, 66, 1.0),
                        ),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Employee ID',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('Name',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              )),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Bus Line',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Bus Number',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text('Phone Number',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('Actions',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              )),
                        ],
                      ),
                      ...snapshot.data!.docs
                          .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                        return TableRow(
                          children: [
                            TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(data['empID'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                )),
                            TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(data['firstName'] + ' ' + data['lastName'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                )),
                            TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(data['busLine'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                )),
                            TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(data['busNumber'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                )),
                            TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(data['phoneNumber'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                )),
                            TableCell(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ElevatedButton(
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
                                                  child: const Text('OK',
                                                      style: TextStyle(
                                                        fontFamily:
                                                        'Wellfleet',
                                                        fontSize: 15.0,
                                                        color:
                                                        Colors.black,
                                                      )),
                                                  onPressed: () {
                                                    FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                        "drivers")
                                                        .doc(document.id)
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
                                                  child: const Text(
                                                      'CANCEL',
                                                      style: TextStyle(
                                                        fontFamily:
                                                        'Wellfleet',
                                                        fontSize: 15.0,
                                                        color:
                                                        Colors.black,
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
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ElevatedButton(
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
                                                child: Text('Bus Information:',
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'Wellfleet',
                                                      fontSize: 20.0,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                              content: SizedBox(
                                                height: 100,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Bus Line: ',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'Wellfleet',
                                                                fontSize:
                                                                16.0)),
                                                        const SizedBox(
                                                          width: 30,
                                                        ),
                                                        SizedBox(
                                                          width: 200,
                                                          height: 30,
                                                          child:
                                                          TextFormField(
                                                              controller:
                                                              _busLine,
                                                              decoration:
                                                              const InputDecoration(
                                                                contentPadding: EdgeInsets.symmetric(
                                                                    vertical: 5.0,
                                                                    horizontal: 10.0),
                                                                border: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color:
                                                                      Colors.grey,
                                                                      width:
                                                                      2.0,
                                                                    )),
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .justify,
                                                              style:
                                                              const TextStyle(
                                                                fontFamily:
                                                                'Wellfleet',
                                                                fontSize:
                                                                16.0,
                                                                color:
                                                                Colors.black,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Bus Number: ',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'Wellfleet',
                                                                fontSize:
                                                                16.0)),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        SizedBox(
                                                          width: 200,
                                                          height: 30,
                                                          child:
                                                          TextFormField(
                                                              controller:
                                                              _busNumber,
                                                              decoration:
                                                              const InputDecoration(
                                                                contentPadding: EdgeInsets.symmetric(
                                                                    vertical: 5.0,
                                                                    horizontal: 10.0),
                                                                border: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color:
                                                                      Colors.grey,
                                                                      width:
                                                                      2.0,
                                                                    )),
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .justify,
                                                              style:
                                                              const TextStyle(
                                                                fontFamily:
                                                                'Wellfleet',
                                                                fontSize:
                                                                16.0,
                                                                color:
                                                                Colors.black,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  child: const Text(
                                                      'SAVE',
                                                      style: TextStyle(
                                                        fontFamily:
                                                        'Wellfleet',
                                                        fontSize: 15.0,
                                                        color:
                                                        Colors.black,
                                                      )),
                                                  onPressed: () async {
                                                    try {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                          'drivers')
                                                          .doc(
                                                          document.id)
                                                          .update({
                                                        'busLine':
                                                        _busLine.text,
                                                        'busNumber':
                                                            _busNumber.text
                                                      });
                                                    } catch (e) {
                                                      Navigator.of(
                                                          context)
                                                          .pop();
                                                    }
                                                    Navigator.of(context)
                                                        .pop();
                                                  },
                                                ),
                                                ElevatedButton(
                                                  child: const Text(
                                                      'CANCEL',
                                                      style: TextStyle(
                                                        fontFamily:
                                                        'Wellfleet',
                                                        fontSize: 15.0,
                                                        color:
                                                        Colors.black,
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
                                          Colors.blue[700]),
                                      child: const Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons
                                                .person_pin_circle_outlined,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            'Edit Bus Info',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: 'Wellfleet',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ElevatedButton(
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
                                                    'Employee Information:',
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'Wellfleet',
                                                      fontSize: 20.0,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                              content: SizedBox(
                                                height: 200,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'First Name: ',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'Wellfleet',
                                                                fontSize:
                                                                16.0)),
                                                        const SizedBox(
                                                          width: 30,
                                                        ),
                                                        SizedBox(
                                                          width: 200,
                                                          height: 30,
                                                          child:
                                                          TextFormField(
                                                              controller:
                                                              _firstName,
                                                              decoration:
                                                              const InputDecoration(
                                                                contentPadding: EdgeInsets.symmetric(
                                                                    vertical: 5.0,
                                                                    horizontal: 10.0),
                                                                border: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color:
                                                                      Colors.grey,
                                                                      width:
                                                                      2.0,
                                                                    )),
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .justify,
                                                              style:
                                                              const TextStyle(
                                                                fontFamily:
                                                                'Wellfleet',
                                                                fontSize:
                                                                16.0,
                                                                color:
                                                                Colors.black,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Last Name: ',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'Wellfleet',
                                                                fontSize:
                                                                16.0)),
                                                        const SizedBox(
                                                          width: 30,
                                                        ),
                                                        SizedBox(
                                                          width: 200,
                                                          height: 30,
                                                          child:
                                                          TextFormField(
                                                              controller:
                                                              _lastName,
                                                              decoration:
                                                              const InputDecoration(
                                                                contentPadding: EdgeInsets.symmetric(
                                                                    vertical: 5.0,
                                                                    horizontal: 10.0),
                                                                border: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color:
                                                                      Colors.grey,
                                                                      width:
                                                                      2.0,
                                                                    )),
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .justify,
                                                              style:
                                                              const TextStyle(
                                                                fontFamily:
                                                                'Wellfleet',
                                                                fontSize:
                                                                16.0,
                                                                color:
                                                                Colors.black,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Phone Number: ',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'Wellfleet',
                                                                fontSize:
                                                                16.0)),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        SizedBox(
                                                          width: 200,
                                                          height: 30,
                                                          child:
                                                          TextFormField(
                                                              controller:
                                                              _phoneNumber,
                                                              decoration:
                                                              const InputDecoration(
                                                                contentPadding: EdgeInsets.symmetric(
                                                                    vertical: 5.0,
                                                                    horizontal: 10.0),
                                                                border: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color:
                                                                      Colors.grey,
                                                                      width:
                                                                      2.0,
                                                                    )),
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .justify,
                                                              style:
                                                              const TextStyle(
                                                                fontFamily:
                                                                'Wellfleet',
                                                                fontSize:
                                                                16.0,
                                                                color:
                                                                Colors.black,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Employee ID: ',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'Wellfleet',
                                                                fontSize:
                                                                16.0)),
                                                        const SizedBox(
                                                          width: 30,
                                                        ),
                                                        SizedBox(
                                                          width: 200,
                                                          height: 30,
                                                          child:
                                                          TextFormField(
                                                              controller:
                                                              _empID,
                                                              decoration:
                                                              const InputDecoration(
                                                                contentPadding: EdgeInsets.symmetric(
                                                                    vertical: 5.0,
                                                                    horizontal: 10.0),
                                                                border: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color:
                                                                      Colors.grey,
                                                                      width:
                                                                      2.0,
                                                                    )),
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .justify,
                                                              style:
                                                              const TextStyle(
                                                                fontFamily:
                                                                'Wellfleet',
                                                                fontSize:
                                                                16.0,
                                                                color:
                                                                Colors.black,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  child: const Text(
                                                      'SAVE',
                                                      style: TextStyle(
                                                        fontFamily:
                                                        'Wellfleet',
                                                        fontSize: 15.0,
                                                        color:
                                                        Colors.black,
                                                      )),
                                                  onPressed: () async {
                                                    try {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                          'drivers')
                                                          .doc(
                                                          document.id)
                                                          .update({
                                                        'firstName':
                                                        _firstName
                                                            .text,
                                                        'lastName':
                                                        _lastName
                                                            .text,
                                                        'phoneNumber':
                                                        _phoneNumber.text,
                                                        'empID':
                                                        _empID.text,
                                                      });
                                                    } catch (e) {
                                                      print('nope');
                                                    }
                                                    Navigator.of(context)
                                                        .pop();
                                                  },
                                                ),
                                                ElevatedButton(
                                                  child: const Text(
                                                      'CANCEL',
                                                      style: TextStyle(
                                                        fontFamily:
                                                        'Wellfleet',
                                                        fontSize: 15.0,
                                                        color:
                                                        Colors.black,
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
                                          backgroundColor: Colors.amber),
                                      child: const Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.info_outline_rounded,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 2.0,
                                          ),
                                          Text(
                                            'Update Info',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontFamily: 'Wellfleet',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      }),
                    ],
                  )
                      : const Center(child: CircularProgressIndicator()),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: const Icon(Icons.logout),
      ),
    );
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
