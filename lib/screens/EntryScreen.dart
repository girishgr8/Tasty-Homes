import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supervisory/screens/Dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supervisory/screens/AppIntro.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    if (authResult.additionalUserInfo.isNewUser) {
      Firestore.instance.collection("users").document().setData({
        "name": user.displayName,
        "email": user.email,
        "bio": "",
        "joinDate": DateTime.now(),
        "photo": user.photoUrl,
        "phone": user.phoneNumber,
        "saved": 0,
      }).whenComplete(() {
        print('New User ${user.displayName} added....!');

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ViewApp(firebaseUser: user),
            ),
            (Route<dynamic> route) => false);
      });
    }
    print("Signed in, Username is: " + user.displayName);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasty Homes'),
        centerTitle: true,
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                icon: Icon(
                  FontAwesomeIcons.googlePlus,
                  color: Colors.redAccent,
                ),
                label: Text('Sign in with Google+'),
                elevation: 2.0,
                onPressed: () {
                  _signIn(context).then(
                    (FirebaseUser fireUser) {
                      print('User ${fireUser.displayName} signed in');
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Dashboard(firebaseUser: fireUser),
                      ));
                    },
                  ).catchError((err) => print(err));
                },
              ),
              RaisedButton.icon(
                icon: Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blue[700],
                ),
                label: Text('Sign in with Facebook'),
                elevation: 2.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EntryScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
