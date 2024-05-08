import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_bus_portal/pages/stdinfo.dart';
import 'busInfo.dart';
import 'home.dart';
import 'login.dart';

class AddBusDriver extends StatefulWidget {
  const AddBusDriver({super.key});

  @override
  _AddBusDriverState createState() => _AddBusDriverState();
}

class _AddBusDriverState extends State<AddBusDriver> {
  final TextEditingController _busLine = TextEditingController();
  final TextEditingController _busNumber = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _empID = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmedpassword = TextEditingController();

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

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _busNumber.dispose();
    _phoneNumber.dispose();
    _empID.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _busLine.dispose();
    _email.dispose();
    _password.dispose();
    _confirmedpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70.0,
        iconTheme: IconThemeData(color: Colors.blue[900]),
        backgroundColor: Colors.white,
        shadowColor: Colors.white24,
        surfaceTintColor: Colors.white,
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
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: [
            DrawerHeader(
              child: Image.asset(
                'lib/assets/images/logo.png',
                width: 50.0,
                height: 50.0,
              ),
            ),
            ListTile(
              selectedColor: Colors.grey[400],
              leading: Icon(
                Icons.dashboard,
                color: Colors.blue[900],
              ),
              title: const Text('Dashboard',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 15.0,
                  )),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
            ),
            ListTile(
              selectedColor: Colors.grey[400],
              leading: Icon(Icons.directions_bus, color: Colors.blue[900]),
              title: const Text('Bus Drivers',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 15.0,
                  )),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BusInfo()));
              },
            ),
            ListTile(
              selectedColor: Colors.grey[400],
              leading: Icon(
                Icons.message,
                color: Colors.blue[900],
              ),
              title: const Text('Messages',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 15.0,
                  )),
              onTap: () {
                Navigator.pushNamed(context, '/messages');
                // Navigator.push(context,MaterialPageRoute(builder: (context) =>const Home()));
              },
            ),
            ListTile(
              selectedColor: Colors.grey[400],
              leading: Icon(
                Icons.person,
                color: Colors.blue[900],
              ),
              title: const Text('Student Files',
                  style: TextStyle(
                    fontFamily: 'Wellfleet',
                    fontSize: 15.0,
                  )),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const StdInfo()));
              },
            ),
            ListTile(
              selectedColor: Colors.grey[400],
              leading: Icon(
                Icons.schedule,
                color: Colors.blue[900],
              ),
              title: const Text('Bus Schedule',
                  style: TextStyle(fontFamily: 'Wellfleet', fontSize: 15.0)),
              onTap: () {
                Navigator.pushNamed(context, '/sched');
                //  Navigator.push(context,MaterialPageRoute(builder: (context) => const Home()));
              },
            ),
            Container(
              color: Colors.grey[200],
              margin: EdgeInsets.fromLTRB(
                  0.0,
                  (getScreenHeight(context) - getScreenHeight(context) * 0.75),
                  0.0,
                  0.0),
              alignment: Alignment.bottomRight,
              child: ListTile(
                title: Row(
                  children: [
                    Image.asset(
                      'lib/assets/images/logo.png',
                      width: 84.0,
                      height: 50.0,
                    ),
                    const Text('Employee ID',
                        style:
                            TextStyle(fontFamily: 'Wellfleet', fontSize: 15.0)),
                  ],
                ),
                tileColor: Colors.grey[200],
                trailing: Icon(
                  Icons.logout_sharp,
                  color: Colors.blue[900],
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Change Password',
                      style:
                          TextStyle(fontFamily: 'Wellfleet', fontSize: 15.0)),
                  Icon(
                    Icons.lock_person,
                    color: Colors.blue[900],
                  ),
                ],
              ),
              onTap: () async {
                try {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: '${user!.email}');
                  _showChangedPasswordDialog(context);
                } on FirebaseAuthException catch (e) {
                  throw Exception(e.message.toString());
                } catch (e) {
                  throw Exception(e.toString());
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
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
          return SingleChildScrollView(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                width: 600,
                child: Form(
                  key: _formKey,
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
                           margin: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                           width: 400,
                           child: TextFormField(
                             controller: _firstName,
                             decoration: InputDecoration(
                                 contentPadding: const EdgeInsets.symmetric(
                                     vertical: 10.0, horizontal: 10.0),
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
                           margin: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                           width: 400,
                           child: TextFormField(
                             controller: _lastName,
                             decoration: InputDecoration(
                                 contentPadding: const EdgeInsets.symmetric(
                                     vertical: 10.0, horizontal: 10.0),
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
                           margin: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                           width: 400,
                           child: TextFormField(
                             controller: _empID,
                             decoration: InputDecoration(
                                 contentPadding: const EdgeInsets.symmetric(
                                     vertical: 10.0, horizontal: 10.0),
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
                          margin: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                           width: 400,
                           child: TextFormField(
                             controller: _email,
                             decoration: InputDecoration(
                               contentPadding: const EdgeInsets.symmetric(
                                   vertical: 10.0, horizontal: 10.0),
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
                           margin: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                           width: 400,
                           child: TextFormField(
                             controller: _phoneNumber,
                             decoration: InputDecoration(
                               contentPadding: const EdgeInsets.symmetric(
                                   vertical: 10.0, horizontal: 10.0),
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
                           margin: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                           width: 400,
                           child: TextFormField(
                             controller: _busNumber,
                             decoration: InputDecoration(
                               contentPadding: const EdgeInsets.symmetric(
                                   vertical: 10.0, horizontal: 10.0),
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
                          margin: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                           width: 400,
                           child: TextFormField(
                             controller: _busLine,
                             decoration: InputDecoration(
                               contentPadding: const EdgeInsets.symmetric(
                                   vertical: 10.0, horizontal: 10.0),
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
                           margin: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                           width: 400,
                           child: TextFormField(
                             controller: _password,
                             decoration: InputDecoration(
                               contentPadding: const EdgeInsets.symmetric(
                                   vertical: 10.0, horizontal: 10.0),
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
                           margin: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                           width: 400,
                           child: TextFormField(
                             controller: _confirmedpassword,
                             decoration: InputDecoration(
                               contentPadding: const EdgeInsets.symmetric(
                                   vertical: 10.0, horizontal: 10.0),
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
                     const SizedBox(height: 20.0,),
                     SizedBox(
                       width: 300,
                       height: 50,
                       child: ElevatedButton(
                           onPressed: (){},
                           style: ElevatedButton.styleFrom(
                             backgroundColor: Colors.blue[900],
                           ),
                           child: const Text("Add Bus Driver",
                           style: TextStyle(
                             fontSize: 17.0,
                             color: Colors.white,
                             fontFamily: 'Wellfleet'
                           ),)),
                     )
                   ],
                                          ),
                ),
              ),
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
