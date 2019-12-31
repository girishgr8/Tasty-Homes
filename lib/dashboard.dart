import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supervisory/addRecipe.dart';
import 'package:supervisory/main.dart';
import 'package:supervisory/navDrawer.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Widget _buildCard() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Girish T',
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Icon(
              Icons.restaurant_menu,
              color: Colors.deepPurple,
              size: 25.0,
            ),
            subtitle: Text('Chef'),
          ),
          Divider(
            color: Colors.deepPurple,
            indent: 20.0,
            endIndent: 20.0,
          ),
          ListTile(
            title: Text(
              'Mexican Jalfrezi',
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            leading: Icon(
              FontAwesomeIcons.delicious,
              color: Colors.deepPurple,
              size: 25.0,
            ),
            subtitle: Text('Dish Name'),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(
                    '20 mins',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  leading: Icon(
                    FontAwesomeIcons.clock,
                    color: Colors.deepPurple,
                    size: 25.0,
                  ),
                  subtitle: Text('Preparation Time'),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    'December 30,2019 at 10:17:00 PM',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  leading: Icon(
                    FontAwesomeIcons.clock,
                    color: Colors.deepPurple,
                    size: 25.0,
                  ),
                  subtitle: Text('Published On'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Book'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.signOutAlt,
                size: 20.0, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('LOGOUT ?'),
                    content: Text('Confirm logout ?'),
                    elevation: 30.0,
                    actions: <Widget>[
                      FlatButton(
                        child: Text('YES'),
                        onPressed: () {
                          _googleSignIn.signOut();
                          print('Signed out');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                title: 'Recipe Book',
                              ),
                            ),
                          );
                        },
                      ),
                      FlatButton(
                        child: Text('NO'),
                        onPressed: () {
                          print("Didn't logout");
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        child: _buildCard(),
      ),
      drawer: MyNavDrawer(
        firebaseUser: widget.firebaseUser,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddReceipe(firebaseUser: widget.firebaseUser),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Recipe',
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Menu'),
            icon: Icon(Icons.menu),
          ),
          BottomNavigationBarItem(
            title: Text('Settings'),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
