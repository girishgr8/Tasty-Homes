import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supervisory/auth/Auth.dart';
import 'package:supervisory/screens/Dashboard.dart';
import 'package:supervisory/screens/Entry.dart';
import 'package:supervisory/animations/FadeIn.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 5),
      () {
        _auth.currentUser().then((FirebaseUser firebaseUser) {
          if (firebaseUser != null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => Dashboard(firebaseUser: firebaseUser),
                ),
                (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => EntryScreen(auth: Auth()),
                ),
                (Route<dynamic> route) => false);
          }
        }).catchError((err) => print(err));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(28, 161, 239, 1)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeIn(
                        1.0,
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50.0,
                          child: Icon(
                            FontAwesomeIcons.book,
                            color: Colors.redAccent,
                            size: 50.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      FadeIn(
                        1.3,
                        Text(
                          'Tasty Homes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(backgroundColor: Colors.white),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    FadeIn(
                      1.4,
                      Text(
                        'Online Recipe Book',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FadeIn(
                      1.6,
                      Text(
                        'For Everyone',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
