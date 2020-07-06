import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supervisory/helpers/classes/Recipe.dart';
import 'package:supervisory/components/AppDrawer.dart';
import 'package:supervisory/helpers/classes/User.dart';
import 'package:supervisory/helpers/services/RecipeService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supervisory/components/RecipeDetail.dart';
import 'package:supervisory/helpers/services/UserService.dart';

class MyRecipePage extends StatefulWidget {
  MyRecipePage({Key key, this.firebaseUser, this.user}) : super(key: key);
  final FirebaseUser firebaseUser;
  final User user;
  @override
  _MyRecipePageState createState() => _MyRecipePageState();
}

class _MyRecipePageState extends State<MyRecipePage> {
  bool isUserDataReady = false, isRecipeReady = false;
  List<Recipe> recipes = [];
  List<String> recipeIDs = [];
  String userDocId;
  User user = new User();

  @override
  void initState() {
    super.initState();
    UserService()
        .getUserData(widget.firebaseUser)
        .listen((QuerySnapshot snapshot) {
      if (snapshot.documents.isNotEmpty) {
        userDocId = snapshot.documents[0].documentID;
        var data = snapshot.documents[0].data;
        user = User(
          email: data['email'],
          name: data['name'],
          phone: data['phone'],
          photo: data['photo'],
          saved: data['saved'],
          liked: data['liked'],
          uid: data['uid'],
          joinedDate: data['joinedDate'],
        );
        print(user.saved);
        setState(() {
          isUserDataReady = true;
        });
      }
    });
    RecipeService().getRecipes().listen((QuerySnapshot snapshot) {
      if (snapshot.documents.isNotEmpty) {
        for (var r in snapshot.documents) {
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
              user: user,
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
                user: user,
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
      drawer: AppDrawer(firebaseUser: widget.firebaseUser),
      body: Container(
        child: isUserDataReady
            ? user.saved.length > 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView.builder(
                      itemCount: user.saved.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildListTile(
                            recipeIDs.indexOf(user.saved[index]));
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
