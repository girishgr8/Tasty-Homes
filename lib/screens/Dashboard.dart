import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supervisory/helpers/classes/Recipe.dart';
import 'package:supervisory/components/AppDrawer.dart';
import 'package:supervisory/components/RecipeDetail.dart';
import 'package:supervisory/helpers/services/RecipeService.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool recipeFlag = false;
  List<Recipe> recipes = [];
  List<String> recipeIDs = [];
  @override
  void initState() {
    super.initState();
    RecipeService().getUserRecipes().then((QuerySnapshot queryDocs) {
      if (queryDocs.documents.isNotEmpty) {
        for (var r in queryDocs.documents) {
          recipeIDs.add(r.documentID);
          recipes.add(Recipe(
            cookingMinutes: r.data['cookingMinutes'],
            cuisines: r.data['cuisines'],
            diets: r.data['diets'],
            dishTypes: r.data['dishTypes'],
            imageUrl: r.data['imageUrl'],
            ingredients: r.data['ingredients'],
            likes: r.data['likes'],
            preparationMinutes: r.data['preparationMinutes'],
            procedure: r.data['procedure'],
            servings: r.data['servings'],
            summary: r.data['summary'],
            title: r.data['title'],
            vegetarian: r.data['vegetarian'],
          ));
        }
      }
      setState(() {
        recipeFlag = true;
      });
    });
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetail(
                    firebaseUser: widget.firebaseUser,
                    recipe: recipes[index],
                    docID: recipeIDs[index],
                  ),
                ),
              );
            },
            leading: Image(
              image: NetworkImage(recipes[index].imageUrl),
            ),
            trailing: InkWell(
              child: Icon(Icons.navigate_next, size: 30.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetail(
                        firebaseUser: widget.firebaseUser,
                        recipe: recipes[index]),
                  ),
                );
              },
            ),
            title: Text(recipes[index].title),
            subtitle: Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.solidCircle,
                  size: 6.0,
                  color: Colors.grey[400],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.0),
                ),
                Text(
                  '${recipes[index].preparationMinutes} mins preparation',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ));
      },
    );
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
        ],
      ),
      body: Container(
        child: recipeFlag == true
            ? _buildList()
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
    "Potato Vada",
    "Delhi",
    "Medu Wada",
    "Potato Chips",
    "Nashik",
    "Chennai",
    "Pav Bhaji",
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

  final recentCities = ["Potato Vada", "Pav Bhaji", "Pizza", "Burger"];

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
          leading: Icon(Icons.restaurant_menu),
          title: Text(suggestionList[index]),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}
