import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'register.dart';
import 'deals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Signin(),
  ));
}

class Signin extends StatefulWidget {
  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String err = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Melo Milk Base'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                    child: Text(
                      "Welcome",
                      style:
                      TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 35,
                left: 20,
                right: 30,
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        )),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    err,
                    style: const TextStyle(color: Colors.red),
                  ),
                  Container(
                    alignment: Alignment(1, 0),
                    padding: EdgeInsets.only(top: 15, left: 20),
                    child: InkWell(
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 40,
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      shadowColor: Colors.greenAccent,
                      color: Colors.black,
                      elevation: 7,
                      child: GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim())
                                .then((value) {
                              // Once the user is signed in, you can get the UID from the User object
                              String uid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              print('User signed in with UID: $uid');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Deals(),
                                ),
                              );
                            }).onError((error, stackTrace) {
                              setState(() {
                                err = error.toString();
                                int index = err.indexOf("]");
                                err = err.substring(index + 1);
                              });
                            });
                          },
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()),
                          );
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
