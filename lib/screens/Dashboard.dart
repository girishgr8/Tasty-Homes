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

  void addTags(List<Widget> inputChips, List<dynamic> list) {
    for (int i = 0; i < list.length; i++) {
      inputChips.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: InputChip(
              avatar: Icon(
                FontAwesomeIcons.tag,
                size: 18.0,
              ),
              label: Text(list[i]),
              onPressed: () {}),
        ),
      );
    }
  }

  List<Widget> _buildTagList(Recipe recipe) {
    List<Widget> inputChips = new List();
    addTags(inputChips, recipe.diets);
    addTags(inputChips, recipe.dishTypes);
    addTags(inputChips, recipe.cuisines);
    return inputChips;
  }

  Widget _buildCardList(int index) {
    return Container(
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border:
                Border.all(color: Color.fromRGBO(28, 161, 239, 1), width: 1.5),
          ),
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(recipes[index].imageUrl),
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                margin: EdgeInsets.all(5.0),
                child: Center(
                  child: Text(
                    recipes[index].title,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(28, 161, 239, 1),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
              Container(
                height: 30,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.heart,
                              size: 18.0,
                              color: Color.fromRGBO(28, 161, 239, 1)),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            recipes[index].likes.toString(),
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      flex: 2,
                      child: recipes[index].vegetarian
                          ? Text(
                              "Vegetarian",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600),
                            )
                          : Text(
                              "Non-Vegetarian",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.fireAlt,
                              size: 20.0, color: Colors.red),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            (recipes[index].preparationMinutes +
                                        recipes[index].cookingMinutes)
                                    .toString() +
                                "m",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(indent: 5.0, endIndent: 5.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _buildTagList(recipes[index]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetail(
                            firebaseUser: widget.firebaseUser,
                            docID: recipeIDs[index],
                            recipe: recipes[index],
                          ),
                        ),
                      );
                    },
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'View Details',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildCardList(index);
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
