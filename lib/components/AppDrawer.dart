import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supervisory/screens/Dashboard.dart';
import 'package:supervisory/screens/SavedRecipes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supervisory/screens/Entry.dart';
import 'package:supervisory/screens/Profile.dart';
import 'package:supervisory/screens/Settings.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> logoutDialog(context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              height: 345.0,
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 150.0,
                      ),
                      Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          color: Color.fromRGBO(28, 161, 239, 1),
                        ),
                      ),
                      Positioned(
                        top: 50.0,
                        left: 90.0,
                        child: Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            border: Border.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 3.0,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(widget.firebaseUser.photoUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'Log out of Tasty Homes',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Divider(),
                  FlatButton(
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Color.fromRGBO(28, 161, 239, 1),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _auth.signOut();
                      print(
                          'User \'${widget.firebaseUser.displayName}\' logged out');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EntryScreen(),
                          ),
                          (Route<dynamic> route) => false);
                    },
                  ),
                  Divider(),
                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 0.0),
                    child: Center(
                      child: Text('Cancel'),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

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
            title: Text('Home'),
            leading: Icon(
              Icons.home,
              size: 28,
              color: Color.fromRGBO(28, 161, 239, 1),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Dashboard(firebaseUser: widget.firebaseUser),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Saved Recipes'),
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
            leading: Icon(
              Icons.account_box,
              size: 28,
              color: Color.fromRGBO(28, 161, 239, 1),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(
              FontAwesomeIcons.signOutAlt,
              size: 22.0,
              color: Color.fromRGBO(28, 161, 239, 1),
            ),
            onTap: () {
              logoutDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
