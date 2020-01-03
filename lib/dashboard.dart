import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supervisory/NewRecipe.dart';
import 'package:supervisory/main.dart';
import 'package:supervisory/navDrawer.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
                          color: Colors.deepPurple,
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
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    onPressed: () {
                      print(
                          'User \'${widget.firebaseUser.displayName}\' logged out');
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasty Homes'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Search Box functionality.....
              showSearch(context: context, delegate: RecipeSearch());
            },
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.signOutAlt,
                size: 20.0, color: Colors.white),
            onPressed: () {
              logoutDialog(context);
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
                  NewRecipe(firebaseUser: widget.firebaseUser),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Recipe',
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       title: Text('Home'),
      //       icon: Icon(Icons.home),
      //     ),
      //     BottomNavigationBarItem(
      //       title: Text('Menu'),
      //       icon: Icon(Icons.menu),
      //     ),
      //     BottomNavigationBarItem(
      //       title: Text('Settings'),
      //       icon: Icon(Icons.settings),
      //     ),
      //   ],
      // ),
    );
  }
}

class RecipeSearch extends SearchDelegate<String> {
  final cities = [
    "Mumbai",
    "Delhi",
    "Nagpur",
    "Kolkata",
    "Nashik",
    "Chennai",
    "Pune",
    "Hyderabad",
    "Noida",
    "Udaipur",
    "Jaipur",
    "Haryana",
    "Srinagar",
    "Bhubaneshwar",
    "Agra",
    "Varanasi",
    "Allahabad",
    "Howrah",
    "Thane",
    "Lucknow",
    "Vadodara",
    "Indore",
    "Surat",
    "Ahemdabad",
    "Kanpur",
    "Meerut",
    "Rajkot",
  ];

  final recentCities = ["Mumbai", "Delhi", "Pune", "Nashik"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      height: 100.0,
      child: Card(
        color: Colors.red,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            showResults(context);
          },
          leading: Icon(Icons.location_city),
          title: Text(suggestionList[index]),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}
