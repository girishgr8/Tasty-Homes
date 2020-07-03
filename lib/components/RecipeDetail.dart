import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:share/share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supervisory/helpers/classes/Recipe.dart';
import 'package:flutter_tts/flutter_tts.dart';

class RecipeDetail extends StatefulWidget {
  RecipeDetail({Key key, this.firebaseUser, this.recipe, this.docID})
      : super(key: key);
  final FirebaseUser firebaseUser;
  final Recipe recipe;
  final String docID;
  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  final FlutterTts _flutterTts = FlutterTts();
  bool liked = false, bookmarked = false, isSpeaking = false;

  Future _readRecipe(Recipe recipe) async {
    await _flutterTts.setLanguage('en-IN');
    String message = "";
    int i;
    message += "Recipe name is ${recipe.title}.${recipe.summary}.";

    message +=
        "Using given ingredients, it can serve upto: ${recipe.servings.toString()} persons and";

    message += recipe.vegetarian
        ? "it is a vegetarian dish."
        : "it is a non-vegetarian dish.";

    message += "${recipe.cookingMinutes} minutes are needed for cooking";

    message += "Ingredients required are ";
    for (i = 0; i < recipe.ingredients.length - 1; i++)
      message += "${recipe.ingredients[i]}, ";
    message += "${recipe.ingredients[i]}.";

    message += "The procedure to prepare this delicious recipe is ";
    for (i = 0; i < recipe.procedure.length - 1; i++)
      message += "${recipe.procedure[i]}";
    message += "${recipe.procedure[i]}.";

    message += "This recipe can be used as: ";
    for (i = 0; i < recipe.dishTypes.length - 1; i++)
      message += "${recipe.dishTypes[i]} or ";
    message += "${recipe.dishTypes[i]}.";
    setState(() {
      isSpeaking = !isSpeaking;
    });
    await _flutterTts.speak(message);
  }

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
    List<Widget> inputChips = new List();
    addTags(inputChips, recipe.diets);
    addTags(inputChips, recipe.dishTypes);
    addTags(inputChips, recipe.cuisines);
    return inputChips;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: Color.fromRGBO(28, 161, 239, 1),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.play_circle_filled,
                color: Color.fromRGBO(28, 161, 239, 1)),
            label: Text("Watch",
                style: TextStyle(color: Color.fromRGBO(28, 161, 239, 1))),
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
                SizedBox(height: 15.0),
                Text(widget.recipe.summary),
                isSpeaking
                    ? FlatButton.icon(
                        onPressed: () {
                          _flutterTts.stop();
                          setState(() {
                            isSpeaking = !isSpeaking;
                          });
                        },
                        label: Text("STOP"),
                        icon: Icon(Icons.stop))
                    : FlatButton.icon(
                        onPressed: () => _readRecipe(widget.recipe),
                        icon: Icon(Icons.volume_up),
                        label: Text("READ RECIPE"),
                      ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Text(
                          'Servings : ${widget.recipe.servings} persons',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            tooltip:
                                liked ? "Already Liked" : "Like the Recipe",
                            icon: liked
                                ? Icon(FontAwesomeIcons.solidHeart,
                                    size: 20.0,
                                    color: Color.fromRGBO(28, 161, 239, 1))
                                : Icon(FontAwesomeIcons.heart, size: 20.0),
                            onPressed: () {
                              setState(() {
                                liked = !liked;
                              });
                            }),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            tooltip: bookmarked
                                ? "Already Saved"
                                : "Save the Recipe",
                            icon: bookmarked
                                ? Icon(Icons.bookmark,
                                    color: Color.fromRGBO(28, 161, 239, 1))
                                : Icon(Icons.bookmark_border),
                            onPressed: () {
                              setState(() {
                                bookmarked = !bookmarked;
                              });
                            }),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          tooltip: "Share",
                          icon: Icon(Icons.share),
                          onPressed: () => share(context),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.0),
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
                            Icon(FontAwesomeIcons.fireAlt,
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
              children: _buildTagList(widget.recipe),
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

  Future<bool> _showImageDialog(String imageUrl) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          insetAnimationDuration: Duration(seconds: 1),
          child: Container(
            height: 230.0,
            width: 300.0,
            child: Column(
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: 300.0,
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(imageUrl),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomImage(String imageUrl) {
    return GestureDetector(
      onTap: () => _showImageDialog(imageUrl),
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image:
              DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
        ),
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
