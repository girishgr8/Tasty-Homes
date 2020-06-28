import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:share/share.dart';
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
  void share(BuildContext context) {
    final RenderBox box = context.findRenderObject();

    Share.share(widget.recipe.title,
        subject: widget.recipe.title,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  Widget _buildIngredient(int idx, String ingredient) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: Color.fromRGBO(28, 161, 239, 1),
          child: Container(
            width: 30.0,
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Center(
              child: Text(
                idx <= 9 ? "0" + idx.toString() : idx.toString(),
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
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
              Text(ingredient, style: TextStyle(fontSize: 16.0)),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

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
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.clock,
                                size: 18.0,
                                color: Color.fromRGBO(28, 161, 239, 1)),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(widget.recipe.preparationMinutes.toString() +
                                "m"),
                          ],
                        ),
                      ),
                      VerticalDivider(),
                      Expanded(
                        flex: 2,
                        child: widget.recipe.vegetarian
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
                            Icon(FontAwesomeIcons.fire,
                                size: 20.0, color: Colors.red),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(widget.recipe.cookingMinutes.toString() + "m"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 5),
                Text(
                  "Ingredients",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(28, 161, 239, 1),
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid),
                ),
                SizedBox(height: 15),
                Column(
                  children: widget.recipe.ingredients
                      .asMap()
                      .entries
                      .map((MapEntry entry) =>
                          _buildIngredient(entry.key + 1, entry.value))
                      .toList(),
                ),
                SizedBox(height: 10.0),
                Divider(),
                SizedBox(height: 10.0),
                Text(
                  "Procedure",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(28, 161, 239, 1),
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid),
                ),
                SizedBox(height: 15),
                Column(
                  children: widget.recipe.procedure
                      .asMap()
                      .entries
                      .map((MapEntry entry) {
                    return Column(
                      children: <Widget>[
                        _buildStep(
                            idx: (entry.key + 1),
                            title: "Step".toUpperCase(),
                            content: entry.value),
                        SizedBox(height: 20.0),
                      ],
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      color: Color.fromRGBO(28, 161, 239, 1),
                      label: Text('Like',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0)),
                      icon:
                          Icon(Icons.thumb_up, size: 20.0, color: Colors.white),
                      onPressed: () {},
                    ),
                    SizedBox(width: 15.0),
                    FlatButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      color: Color.fromRGBO(28, 161, 239, 1),
                      label: Text('Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0)),
                      icon: Icon(Icons.bookmark_border,
                          size: 22.0, color: Colors.white),
                      onPressed: () {},
                    ),
                    SizedBox(width: 15.0),
                    FlatButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      color: Color.fromRGBO(28, 161, 239, 1),
                      label: Text('Share',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0)),
                      icon: Icon(Icons.share, size: 20.0, color: Colors.white),
                      onPressed: () => share(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
            margin: EdgeInsets.symmetric(vertical: 0.0),
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              children: widget.recipe.diets.map((label) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: InputChip(
                      avatar: Icon(
                        FontAwesomeIcons.tag,
                        size: 18.0,
                      ),
                      label: Text(label),
                      onPressed: () {}),
                );
              }).toList(),
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
          ),
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

  Widget _buildStep({int idx, String title, String content}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: Color.fromRGBO(28, 161, 239, 1),
          child: Container(
            width: 35.0,
            padding: EdgeInsets.all(5.0),
            child: Center(
              child: Text(
                idx <= 9 ? "0" + idx.toString() : idx.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
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
        ),
      ],
    );
  }
}
