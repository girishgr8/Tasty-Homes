import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  var recipes;

  @override
  void initState() {
    super.initState();
    RecipeService()
        .getUserRecipes(widget.firebaseUser.displayName)
        .then((QuerySnapshot queryDocs) {
      if (queryDocs.documents.isNotEmpty) {
        setState(() {
          recipeFlag = true;
          recipes = queryDocs.documents[1].data;
        });
      } else {
        setState(() {});
      }
    });
  }

  Widget _buildCard() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Recipes'),
        centerTitle: true,
      ),
      body: Container(
        child: recipeFlag
            ? Card(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(recipes['chef']),
                      Text(recipes['recipeName']),
                      Text('Preparation Time: ${recipes['prepTime']}'),
                      Text('Read Time: ${recipes['readTime']}'),
                      Text('Likes: ${recipes['likes'].toString()}'),
                    ],
                  ),
                ),
              )
            : Card(
                child: Text("No Recipe Available..."),
              ),
      ),
      // : Container(
      //     child: Column(
      //       children: <Widget>[
      //         Center(
      //           child: Text('You are not logged in. Please login first !'),
      //         ),
      //         RaisedButton(
      //           onPressed: () {
      //             Navigator.pop(context);
      //           },
      //           child: Text('Back'),
      //         )
      //       ],
      //     ),
      //   ),
    );
  }
}
