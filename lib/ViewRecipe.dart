import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supervisory/Recipe.dart';

class ViewRecipe extends StatelessWidget {
  final Recipe recipe;
  final String id;
  final FirebaseUser firebaseUser;

  ViewRecipe({this.recipe, this.firebaseUser, this.id});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('View Recipe'),
          centerTitle: true,
          titleSpacing: 1.0,
        ),
        body: Container(
          padding: EdgeInsets.all(5.0),
          child: Card(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/images/recipe.jpg'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 50.0)),
                        Center(
                          child: Text(
                            '${recipe.recipeName}',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 40.0,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.clock,
                                    size: 15.0,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                  ),
                                  Text('Preparation: ${recipe.prepTime} mins'),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 40.0,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.solidCircle,
                                    size: 9.0,
                                    color: Colors.grey[600],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.0)),
                                  Text('${recipe.readTime} mins read',
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.calendar_today, size: 18.0),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3.0)),
                                Text(
                                    '${recipe.pubDate.toDate().toString().split(' ')[0]}  at  ${recipe.pubDate.toDate().toString().split(' ')[1].split('.')[0]}'),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.thumb_up, size: 18.0),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0)),
                                Text(recipe.likes.toString()),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                    Text(
                      'Ingredients',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16.0,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                        color: Colors.deepPurple[400],
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                    Text(recipe.ingredients),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                    Text(
                      'Procedure',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16.0,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                        color: Colors.deepPurple[400],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    Text(recipe.procedure),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                    recipe.chef != firebaseUser.displayName
                        ? Column(
                            children: <Widget>[
                              Divider(thickness: 0.8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  FlatButton.icon(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4.0),
                                    icon: Icon(Icons.thumb_up),
                                    label: Text('Like'),
                                    onPressed: () {
                                      print('Recipe Liked');
                                    },
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0)),
                                  FlatButton.icon(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4.0),
                                    icon: Icon(Icons.comment),
                                    label: Text('Comment'),
                                    onPressed: () {
                                      print('Commented on Recipe');
                                    },
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 13.0)),
                                  IconButton(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
                                    icon: Icon(
                                      Icons.bookmark_border,
                                      size: 25.0,
                                    ),
                                    onPressed: () {
                                      print('Pressed');
                                    },
                                  ),
                                ],
                              )
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
