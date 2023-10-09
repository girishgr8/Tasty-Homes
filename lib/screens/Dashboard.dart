import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supervisory/helpers/classes/Recipe.dart';
import 'package:supervisory/components/AppDrawer.dart';
import 'package:supervisory/components/RecipeDetail.dart';
import 'package:supervisory/helpers/classes/AppUser.dart';
import 'package:supervisory/helpers/services/RecipeService.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key, required this.firebaseUser, this.appUser}) : super(key: key);
  final User firebaseUser;
  final AppUser? appUser;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isRecipeDataAvailable = false, isUserDataAvailable = false;
  List<Recipe> recipes = [];
  List<String> recipeIDs = [];
  String userDocId = "";
  AppUser? appUser;
  @override
  void initState() {
    super.initState();
    // UserService()
    //     .getUserData(widget.firebaseUser).then((obj) => {
    //         // var dataObj = ;
    //         this.appUser = AppUser(
    //           email: obj.docs[0]['email'],
    //           name: obj.docs[0]['name'],
    //           phone: obj.docs[0]['phone'],
    //           photo: obj.docs[0]['photo'],
    //           saved: obj.docs[0]['saved'],
    //           liked: obj.docs[0]['liked'],
    //           uid: obj.docs[0]['uid'],
    //           joinedDate: obj.docs[0]['joinedDate'],
    //       )
    //     });
        // .listen((QuerySnapshot snapshot) {
      // if (snapshot.docs.isNotEmpty) {
      //   userDocId = snapshot.docs[0].id;
      //   var data = snapshot.docs[0];
      //   this.appUser = AppUser(
      //     email: data['email'],
      //     name: data['name'],
      //     phone: data['phone'],
      //     photo: data['photo'],
      //     saved: data['saved'],
      //     liked: data['liked'],
      //     uid: data['uid'],
      //     joinedDate: data['joinedDate'],
      //   );
      // }
    // });

    RecipeService().getRecipes().listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var r in snapshot.docs) {

          recipeIDs.add(r.id);
          recipes.add(Recipe(
            cookingMinutes: r['cookingMinutes'],
            cuisines: r['cuisines'],
            diets: r['diets'],
            dishTypes: r['dishTypes'],
            imageUrl: r['imageUrl'],
            ingredients: r['ingredients'],
            likes: r['likes'],
            preparationMinutes: r['preparationMinutes'],
            procedure: r['procedure'],
            servings: r['servings'],
            summary: r['summary'],
            title: r['title'],
            vegetarian: r['vegetarian'],
          ));
        }
      }
      setState(() {
        isRecipeDataAvailable = true;
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
    List<Widget> inputChips = new List<Widget>.empty(growable: true);
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
                height: 180.0,
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetail(
                            appUser: widget.appUser!,
                            userDocId: userDocId,
                            firebaseUser: widget.firebaseUser,
                            recipeDocId: recipeIDs[index],
                            recipe: recipes[index],
                          ),
                        ),
                      );
                    },
                    // color: Theme.of(context).accentColor,
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
        child: isRecipeDataAvailable
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
      drawer: AppDrawer(appUser: widget.appUser, firebaseUser: widget.firebaseUser),
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
        close(context, "");
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
