import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

import 'FireAuth.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();



  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }
    return firebaseApp;
  }

  @override
  void dispose (){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //Regression Expression for Admin Email
  bool isEmailValid(String email) {
    const pattern = r'^[a-zA-Z]{3}\d{8}@psut.edu.jo$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
  //Regression Expression for Admin Password
  bool isPasswordValid(String password) {
    return password.length == 8;
  }

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is not signed in');
      } else {
        print('User is signed in: ${user.email}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FooterView(
          footer: Footer(
              child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:<Widget>[
                    Text('© 2024 Princess Sumaya University for Technology . All Rights Reserved.',
                    style: TextStyle(
                      fontFamily: 'Wellfleet',
                      fontSize: 13.0,
                    ),),
                  ]
              ),

            ),
          children: [
            Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 90),
                    Image.asset(
                      'lib/assets/images/logo.png',
                      // width: 84.0,
                      // height: 50.0,
                    ),
                    const Text('PSUT MyBus',
                      style: TextStyle(
                        fontFamily: 'Wellfleet',
                        fontSize: 40.0,
                      ),),
                    const SizedBox(height: 20.0,),
                    Container(
                      width: 450.0,
                      height: 40.0,
                      padding: const EdgeInsets.fromLTRB(5.0,0.0, 0.0, 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (psEmail) {
                          if (isEmailValid(psEmail!)) {
                            return null;
                          } else {
                            return 'Invalid Student Email!';
                          }
                        },
                        style: const TextStyle(
                          fontFamily: 'Wellfleet',
                          fontSize: 16.0,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Employee Email',
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                            fontSize: 16.0,
                            fontFamily: 'Wellfleet',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Container(
                          width: 450.0,
                          height: 40.0,
                          padding: const EdgeInsets.fromLTRB(5.0,0.0, 0.0, 10.0),

                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (psPassword) {
                              if (isPasswordValid(psPassword!)) {
                                return null;
                              } else {
                                return 'Invalid Password!';
                              }
                            },
                            style: const TextStyle(
                              fontFamily: 'Wellfleet',
                              fontSize: 16.0,
                            ),
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorStyle: TextStyle(
                                color: Colors.red[900],
                                fontSize: 16.0,
                                fontFamily: 'Wellfleet',
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 320.0,
                      height: 48.0,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                User? user = await FireAuth.signInUsingEmail(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                                if (user != null) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const Home()),
                                  );
                                }
                              } on FirebaseAuthException catch (e) {
                                print(e);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color.fromRGBO(11, 39, 143, 1.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0)),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Wellfleet',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 70.0,
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: _emailController.text.trim());
                            _showAlertDialog(context);
                          } on FirebaseAuthException catch (e) {
                            throw Exception(e.message.toString());
                          } catch (e) {
                            throw Exception(e.toString());
                          }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const PSForget()),
                          // );
                        },
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromRGBO(11, 39, 143, 1.0),
                            fontSize: 16.0,
                            fontFamily: 'Wellfleet',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
        ),
        ),
    );
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