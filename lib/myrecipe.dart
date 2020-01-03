import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supervisory/ViewRecipe.dart';
import 'package:supervisory/services/RecipeService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyRecipePage extends StatefulWidget {
  MyRecipePage({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _MyRecipePageState createState() => _MyRecipePageState();
}

class _MyRecipePageState extends State<MyRecipePage> {
  bool recipeFlag = false;
  List<RecipeService> recipes = [];
  @override
  void initState() {
    super.initState();
    RecipeService()
        .getUserRecipes(widget.firebaseUser.displayName)
        .then((QuerySnapshot queryDocs) {
      if (queryDocs.documents.isNotEmpty) {
        setState(() {
          recipeFlag = true;
        });

        for (var r in queryDocs.documents) {
          recipes.add(RecipeService(
            chef: r.data['chef'],
            recipeName: r.data['recipeName'],
            prepTime: r.data['prepTime'],
            readTime: r.data['readTime'],
            procedure: r.data['procedure'],
            ingredients: r.data['ingredients'],
            likes: r.data['likes'],
            pubDate: r.data['pubDate'],
          ));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Recipes'),
        centerTitle: true,
      ),
      body: Container(
        child: recipeFlag == true
            ? ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewRecipe(
                                      recipe: recipes[index],
                                    )));
                      },
                      leading: Image(
                        image:
                            AssetImage('assets/images/profile-background.jpg'),
                      ),
                      trailing: InkWell(
                        child: Icon(Icons.navigate_next, size: 30.0),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewRecipe(
                                        recipe: recipes[index],
                                      )));
                        },
                      ),
                      title: Text(recipes[index].recipeName),
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
                            '${recipes[index].readTime} mins read',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ));
                },
              )
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
    );
  }
}
