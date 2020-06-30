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

  // Widget _buildCardList(int index) {
  //   return InkWell(
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
  //     child: Card(
  //       margin: EdgeInsets.all(10.0),
  //       child: Container(
  //         padding: EdgeInsets.symmetric(horizontal: 5.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Container(
  //               margin: EdgeInsets.all(5.0),
  //               child: Center(
  //                 child: Text(
  //                   recipes[index].recipeName,
  //                   style: TextStyle(
  //                     fontSize: 20.0,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.blue[800],
  //                     fontFamily: 'Montserrat',
  //                     fontStyle: FontStyle.italic,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               margin: EdgeInsets.symmetric(horizontal: 15.0),
  //               child: Center(
  //                 child: Image(
  //                   image: AssetImage('assets/images/recipe.jpg'),
  //                   fit: BoxFit.fill,
  //                 ),
  //               ),
  //             ),
  //             Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
  //             Row(
  //               children: <Widget>[
  //                 Expanded(
  //                   flex: 1,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       Icon(Icons.thumb_up, size: 18.0),
  //                       SizedBox(width: 8.0),
  //                       Text(recipes[index].likes.toString()),
  //                     ],
  //                   ),
  //                 ),
  //                 Expanded(
  //                   flex: 1,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: <Widget>[
  //                       Icon(FontAwesomeIcons.clock, size: 15.0),
  //                       SizedBox(width: 8.0),
  //                       Text('${recipes[index].prepTime} mins'),
  //                     ],
  //                   ),
  //                 ),
  //                 Expanded(
  //                   flex: 1,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: <Widget>[
  //                       Icon(
  //                         FontAwesomeIcons.bookReader,
  //                         size: 15.0,
  //                         color: Colors.grey[600],
  //                       ),
  //                       SizedBox(width: 8.0),
  //                       Text('${recipes[index].readTime} mins'),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             // Padding(
  //             //     padding: EdgeInsets.symmetric(vertical: 5.0)),
  //             Divider(indent: 5.0, endIndent: 5.0),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 5.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text(
  //                     'Ingredients',
  //                     style: TextStyle(
  //                       fontStyle: FontStyle.italic,
  //                       fontSize: 16.0,
  //                       decoration: TextDecoration.underline,
  //                       fontWeight: FontWeight.w700,
  //                       color: Colors.deepPurple[400],
  //                     ),
  //                   ),
  //                   Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
  //                   ExpandableText(text: recipes[index].ingredients),
  //                   Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
  //                   Text(
  //                     'Procedure',
  //                     style: TextStyle(
  //                       fontStyle: FontStyle.italic,
  //                       fontSize: 16.0,
  //                       decoration: TextDecoration.underline,
  //                       fontWeight: FontWeight.w700,
  //                       color: Colors.deepPurple[400],
  //                     ),
  //                   ),
  //                   Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
  //                   ExpandableText(text: recipes[index].procedure),
  //                   Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 10.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: <Widget>[
  //                   RaisedButton.icon(
  //                     textColor: Colors.white,
  //                     color: Colors.pink,
  //                     icon: Icon(Icons.edit),
  //                     label: Text('Edit'),
  //                     onPressed: () {},
  //                   ),
  //                   RaisedButton.icon(
  //                     textColor: Colors.white,
  //                     color: Colors.pink,
  //                     icon: Icon(Icons.delete),
  //                     label: Text('Delete'),
  //                     onPressed: () {},
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
  //           ],
  //         ),
  //       ),
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

class ExpandableText extends StatefulWidget {
  bool isExpanded = false;
  final String text;
  ExpandableText({this.text});
  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AnimatedSize(
          vsync: this,
          duration: Duration(milliseconds: 500),
          child: ConstrainedBox(
            constraints: widget.isExpanded
                ? BoxConstraints()
                : BoxConstraints.expand(height: 20.0),
            child: Text(
              widget.text,
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
        widget.isExpanded
            ? ConstrainedBox(constraints: BoxConstraints())
            : IconButton(
                color: Colors.pinkAccent[100],
                icon: Icon(Icons.arrow_downward),
                onPressed: () {
                  setState(() {
                    widget.isExpanded = true;
                  });
                },
              ),
      ],
    );
  }
}