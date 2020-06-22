import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supervisory/NewRecipe.dart';
import 'package:supervisory/Recipe.dart';
import 'package:supervisory/components/AppDrawer.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool recipeFlag = false;
  List<Recipe> recipes = [];
  List<String> docID = [];
  // @override
  // void initState() {
  //   super.initState();
  //   RecipeService().getAllRecipes().then((QuerySnapshot queryDocs) {
  //     if (queryDocs.documents.isNotEmpty) {
  //       for (var r in queryDocs.documents) {
  //         if (r.data['chef'] != widget.firebaseUser.displayName) {
  //           docID.add(r.documentID);
  //           recipes.add(Recipe(
  //             chef: r.data['chef'],
  //             recipeName: r.data['recipeName'],
  //             prepTime: r.data['prepTime'],
  //             readTime: r.data['readTime'],
  //             procedure: r.data['procedure'],
  //             ingredients: r.data['ingredients'],
  //             likes: r.data['likes'],
  //             pubDate: r.data['pubDate'],
  //           ));
  //         }
  //       }
  //     }
  //     setState(() {
  //       recipeFlag = true;
  //     });
  //   });
  // }

  // Widget _buildList() {
  //   return ListView.builder(
  //     itemCount: recipes.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return ListTile(
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => ViewRecipe(
  //                   id: docID[index],
  //                   recipe: recipes[index],
  //                   firebaseUser: widget.firebaseUser,
  //                 ),
  //               ),
  //             );
  //           },
  //           leading: Image(
  //             image: AssetImage('assets/images/recipe.jpg'),
  //           ),
  //           trailing: InkWell(
  //             child: Icon(Icons.navigate_next, size: 30.0),
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => ViewRecipe(
  //                     id: docID[index],
  //                     recipe: recipes[index],
  //                     firebaseUser: widget.firebaseUser,
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //           title: Text(recipes[index].recipeName),
  //           subtitle: Row(
  //             children: <Widget>[
  //               Icon(
  //                 FontAwesomeIcons.solidCircle,
  //                 size: 6.0,
  //                 color: Colors.grey[400],
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: 3.0),
  //               ),
  //               Text(
  //                 '${recipes[index].readTime} mins read',
  //                 style: TextStyle(fontSize: 12.0),
  //               ),
  //             ],
  //           ));
  //     },
  //   );
  // }

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
        ],
      ),
      body: Container(
        child: recipeFlag == false
            ? Container()
            : Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(padding: EdgeInsets.symmetric(vertical: 20.0)),
                      Text('Loading.....'),
                    ],
                  ),
                ),
              ),
      ),
      drawer: AppDrawer(firebaseUser: widget.firebaseUser),
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
