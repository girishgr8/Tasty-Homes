import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supervisory/navDrawer.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${widget.firebaseUser.displayName}'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Image.network(widget.firebaseUser.photoUrl),
            Text('Name: ${widget.firebaseUser.displayName}'),
            Text('Email: ${widget.firebaseUser.email}'),
          ],
        ),
      ),
      drawer: MyNavDrawer(
        firebaseUser: widget.firebaseUser,
      ),
    );
  }
}
