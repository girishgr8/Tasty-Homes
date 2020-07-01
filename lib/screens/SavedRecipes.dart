import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supervisory/helpers/classes/Recipe.dart';
import 'package:supervisory/components/AppDrawer.dart';
import 'package:supervisory/helpers/services/RecipeService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supervisory/components/RecipeDetail.dart';

class MyRecipePage extends StatefulWidget {
  MyRecipePage({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _MyRecipePageState createState() => _MyRecipePageState();
}

class _MyRecipePageState extends State<MyRecipePage> {
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
        print(recipes[0].diets);
      }
      setState(() {
        recipeFlag = true;
      });
    });
  }

  // Widget _buildListTile(int index) {
  //   return ListTile(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ViewRecipe(
  //             id: docID[index],
  //             recipe: recipes[index],
  //             firebaseUser: widget.firebaseUser,
  //           ),
  //         ),
  //       );
  //     },
  //     leading: Image(
  //       image: AssetImage('assets/images/recipe.jpg'),
  //     ),
  //     trailing: InkWell(
  //       child: Icon(Icons.navigate_next, size: 30.0),
  //       onTap: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => ViewRecipe(
  //               id: docID[index],
  //               recipe: recipes[index],
  //               firebaseUser: widget.firebaseUser,
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //     title: Text(recipes[index].recipeName),
  //     subtitle: Row(
  //       children: <Widget>[
  //         Icon(
  //           FontAwesomeIcons.solidCircle,
  //           size: 6.0,
  //           color: Colors.grey[400],
  //         ),
  //         Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 3.0),
  //         ),
  //         Text(
  //           '${recipes[index].readTime} mins read',
  //           style: TextStyle(fontSize: 12.0),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Recipes'),
        centerTitle: true,
      ),
      drawer: AppDrawer(firebaseUser: widget.firebaseUser),
      body: Container(
        // child: recipeFlag == true
        //     ? ListView.builder(
        //         itemCount: recipes.length,
        //         itemBuilder: (BuildContext context, int index) {
        //           // return _buildListTile(index);
        //           return _buildCardList(index);
        //         },
        //       )
        //     : Center(
        //         child: Container(
        //           padding: EdgeInsets.symmetric(vertical: 50.0),
        //           child: Column(
        //             children: <Widget>[
        //               CircularProgressIndicator(),
        //               Padding(padding: EdgeInsets.symmetric(vertical: 20.0)),
        //               Text('Loading.....'),
        //             ],
        //           ),
        //         ),
        //       ),
        child: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecipeDetail(
                        firebaseUser: widget.firebaseUser,
                        recipe: recipes[2],
                        docID: recipeIDs[2],
                      ),
                    ),
                  );
                },
                child: Text("View Details".toUpperCase()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
