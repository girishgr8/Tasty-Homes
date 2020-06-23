import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supervisory/Recipe.dart';

class RecipeDetail extends StatefulWidget {
  RecipeDetail({Key key, this.firebaseUser, this.recipe}) : super(key: key);
  final FirebaseUser firebaseUser;
  final Recipe recipe;
  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(28, 161, 239, 1),
        title: Text('Recipe Details'),
        leading: IconButton(
          icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          FlatButton.icon(
            textColor: Colors.white,
            splashColor: Colors.blueAccent,
            icon: Icon(Icons.play_circle_filled, color: Colors.white),
            label: Text(
              "Watch",
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                Center(
                  child: Text(
                    widget.recipe.title,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(widget.recipe.summary),
                SizedBox(height: 20.0),
                Container(
                  height: 30,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.clock, size: 18.0),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(widget.recipe.preparationMinutes.toString() +
                                "mins"),
                          ],
                        ),
                      ),
                      VerticalDivider(),
                      Expanded(
                        child: widget.recipe.vegetarian
                            ? Text(
                                "Vegetarian",
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                "Non-Vegetarian",
                                textAlign: TextAlign.center,
                              ),
                      ),
                      VerticalDivider(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.fastfood, size: 20.0),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(widget.recipe.cookingMinutes.toString() +
                                "mins"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                _buildStep(
                    leadingTitle: "01",
                    title: "Step".toUpperCase(),
                    content: widget.recipe.procedure[0]),
                SizedBox(
                  height: 30.0,
                ),
                _buildStep(
                    leadingTitle: "02",
                    title: "Step".toUpperCase(),
                    content: widget.recipe.procedure[1]),
                SizedBox(
                  height: 30.0,
                ),
                _buildStep(
                    leadingTitle: "03",
                    title: "Step".toUpperCase(),
                    content: widget.recipe.procedure[2]),
                SizedBox(
                  height: 30.0,
                ),
                _buildStep(
                    leadingTitle: "04",
                    title: "Step".toUpperCase(),
                    content: widget.recipe.procedure[3]),
                SizedBox(
                  height: 30.0,
                ),
                _buildStep(
                    leadingTitle: "05",
                    title: "Step".toUpperCase(),
                    content: widget.recipe.procedure[4]),
              ],
            ),
          ),
          Material(
            elevation: 10.0,
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.all(10.0),
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildBottomImage(widget.recipe.imageUrl),
                  SizedBox(
                    width: 10.0,
                  ),
                  _buildBottomImage(widget.recipe.imageUrl),
                  SizedBox(
                    width: 10.0,
                  ),
                  _buildBottomImage(widget.recipe.imageUrl),
                  SizedBox(
                    width: 10.0,
                  ),
                  _buildBottomImage(widget.recipe.imageUrl),
                  SizedBox(
                    width: 10.0,
                  ),
                  _buildBottomImage(widget.recipe.imageUrl),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildBottomImage(String imageUrl) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image:
            DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildStep({String leadingTitle, String title, String content}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: Colors.red,
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              leadingTitle,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              SizedBox(
                height: 10.0,
              ),
              Text(content),
            ],
          ),
        )
      ],
    );
  }
}
