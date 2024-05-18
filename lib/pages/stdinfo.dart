import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_bus_portal/elements/AlertDialogs/deleteInfo.dart';
import 'package:my_bus_portal/elements/Drawer.dart';
import 'login.dart';

class StdInfo extends StatefulWidget {
  const StdInfo({super.key});

  @override
  _StdInfoState createState() => _StdInfoState();
}

class _StdInfoState extends State<StdInfo> {
  final TextEditingController _busLine = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _studentID = TextEditingController();

  double getScreenHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight;
  }

  CollectionReference users = FirebaseFirestore.instance.collection('students');
  User? user = FirebaseAuth.instance.currentUser;

  double getScreenWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }

  @override
  void dispose (){
    _email.dispose();
    _studentID.dispose();
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
                  child: const Text(
                    'Students Files',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                    ),
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
                            4: FlexColumnWidth(3),
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
                                    child: Text('Student ID',
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
                                      child: Text('Financial Status',
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
                                    child: Text(data['studentID'] ?? 'none',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(data['firstName'] + ' ' + data['lastName'] ?? 'none',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  )),
                                  const TableCell(
                                      child: Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text('Paid',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(data['busLine'] ?? 'none',
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
                                          child: DeleteInfo(collectionName: 'students', docID: document.id),
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
                                                      child: Text('Bus Line:',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Wellfleet',
                                                            fontSize: 20.0,
                                                            color: Colors.black,
                                                          )),
                                                    ),
                                                    content: TextFormField(
                                                        controller: _busLine,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              'Wellfleet',
                                                          fontSize: 16.0,
                                                          color: Colors.black,
                                                        )),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                          const Color.fromRGBO(11, 39, 143, 1.0),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(40.0)),
                                                        ),
                                                        child: const Text(
                                                            'SAVE',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Wellfleet',
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                        onPressed: () async {
                                                          try {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'students')
                                                                .doc(
                                                                    document.id)
                                                                .update({
                                                              'busLine':
                                                                  _busLine.text
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
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                          const Color.fromRGBO(11, 39, 143, 1.0),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(40.0)),
                                                        ),
                                                        child: const Text(
                                                            'CANCEL',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Wellfleet',
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.white,
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
                                                  'Edit Bus Line',
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
                                                          'Student Information:',
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
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text(
                                                                  'Email: ',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Wellfleet',
                                                                      fontSize:
                                                                          16.0)),
                                                              const SizedBox(
                                                                width: 65,
                                                              ),
                                                              SizedBox(
                                                                width: 200,
                                                                height: 30,
                                                                child:
                                                                    TextFormField(
                                                                        controller:
                                                                            _email,
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
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const Text(
                                                                  'Student ID: ',
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
                                                                            _studentID,
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
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                          const Color.fromRGBO(11, 39, 143, 1.0),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(40.0)),
                                                        ),
                                                        child: const Text(
                                                            'SAVE',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Wellfleet',
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                        onPressed: () async {
                                                          try {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'students')
                                                                .doc(
                                                                    document.id)
                                                                .update({
                                                              'firstName':
                                                                  _firstName
                                                                      .text,
                                                              'lastName':
                                                                  _lastName
                                                                      .text,
                                                              'email':
                                                                  _email.text,
                                                              'studentID':
                                                                  _studentID.text,
                                                            });
                                                          } catch (e) {
                                                            print('nope');
                                                          }
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                          const Color.fromRGBO(11, 39, 143, 1.0),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(40.0)),
                                                        ),
                                                        child: const Text(
                                                            'CANCEL',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Wellfleet',
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.white,
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
