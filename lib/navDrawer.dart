import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supervisory/MyRecipe.dart';
import 'package:supervisory/profile.dart';

class MyNavDrawer extends StatefulWidget {
  MyNavDrawer({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _MyNavDrawerState createState() => _MyNavDrawerState();
}

class _MyNavDrawerState extends State<MyNavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(widget.firebaseUser.displayName),
            accountEmail: Text(widget.firebaseUser.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(widget.firebaseUser.photoUrl),
            ),
          ),
          ListTile(
            title: Text('My Recipes'),
            leading: Icon(
              Icons.restaurant_menu,
              size: 28,
              color: Colors.red[600],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyRecipePage(
                    firebaseUser: widget.firebaseUser,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Account'),
            //subtitle: Text('Account Info'),
            leading: Icon(
              Icons.account_box,
              size: 28,
              color: Colors.blueAccent[400],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Profile(firebaseUser: widget.firebaseUser),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(
              Icons.settings,
              size: 28,
              color: Colors.grey[700],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
