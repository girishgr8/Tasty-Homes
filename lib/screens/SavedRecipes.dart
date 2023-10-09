// import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:supercharged/supercharged.dart';
import 'package:supervisory/helpers/classes/Recipe.dart';
import 'package:supervisory/components/AppDrawer.dart';
import 'package:supervisory/helpers/classes/AppUser.dart';
import 'package:supervisory/helpers/services/RecipeService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supervisory/components/RecipeDetail.dart';
import 'package:supervisory/helpers/services/UserService.dart';

class MyRecipePage extends StatefulWidget {
  MyRecipePage({Key? key, required this.firebaseUser, this.appUser}) : super(key: key);
  final User firebaseUser;
  final AppUser? appUser;
  @override
  _MyRecipePageState createState() => _MyRecipePageState();
}

class _MyRecipePageState extends State<MyRecipePage> {
  bool isUserDataReady = false, isRecipeReady = false;
  List<Recipe> recipes = [];
  List<String> recipeIDs = [];
  String userDocId = "";
  AppUser? user;

  @override
  void initState() {
    super.initState();
    
    // UserService()
    //     .getUserData(widget.firebaseUser)
    //     .listen((QuerySnapshot snapshot) {
    //   if (snapshot.docs.isNotEmpty) {
    //     userDocId = snapshot.docs[0].id;
    //     QueryDocumentSnapshot<Object?> data = snapshot.docs[0];
    //     user = AppUser(
    //       email: data.get('email'),
    //       name: data['name'],
    //       phone: data['phone'],
    //       photo: data['photo'],
    //       saved: data['saved'],
    //       liked: data['liked'],
    //       uid: data['uid'],
    //       joinedDate: data['joinedDate'],
    //     );
    //     print(user!.saved);
    //     setState(() {
    //       isUserDataReady = true;
    //     });
    //   }
    // });

    UserService()
        .getUserData(widget.firebaseUser).then((obj) => {
            // var dataObj = ;
            this.user = AppUser(
              email: obj.docs[0]['email'],
              name: obj.docs[0]['name'],
              phone: obj.docs[0]['phone'],
              photo: obj.docs[0]['photo'],
              saved: obj.docs[0]['saved'],
              liked: obj.docs[0]['liked'],
              uid: obj.docs[0]['uid'],
              joinedDate: obj.docs[0]['joinedDate'],
          ),
          
        setState(() {
          isUserDataReady = true;
        })
        });
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
        isRecipeReady = true;
      });
    });
  }

  Widget _buildListTile(int index) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetail(
              appUser: widget.appUser!,
              userDocId: userDocId,
              recipeDocId: recipeIDs[index],
              recipe: recipes[index],
              firebaseUser: widget.firebaseUser,
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
                appUser: widget.appUser!,
                userDocId: userDocId,
                recipeDocId: recipeIDs[index],
                recipe: recipes[index],
                firebaseUser: widget.firebaseUser,
              ),
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
            '${recipes[index].cookingMinutes} mins to cook',
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Recipes'),
        centerTitle: true,
      ),
      drawer: AppDrawer(appUser: widget.appUser, firebaseUser: widget.firebaseUser),
      body: Container(
        child: isUserDataReady
            ? user!.saved.length > 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView.builder(
                      itemCount: user!.saved.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildListTile(
                            recipeIDs.indexOf(user!.saved[index]));
                      },
                    ),
                  )
                : Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 50.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0)),
                          Text('Oops !! You have not saved any recipes'),
                        ],
                      ),
                    ),
                  )
            : Container(child: CircularProgressIndicator()),
      ),
    );
  }
}
