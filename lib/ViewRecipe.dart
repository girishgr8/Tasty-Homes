import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supervisory/services/RecipeService.dart';

class ViewRecipe extends StatelessWidget {
  final RecipeService recipe;

  ViewRecipe({this.recipe});

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
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/images/profile-background.jpg'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(Icons.calendar_today),
                        Text(recipe.pubDate.toDate().toString().split(' ')[0]),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
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
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                    Text('${recipe.ingredients}'),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
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
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    Text(recipe.procedure),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: <Widget>[
                    //     Text('Watch the video'),
                    //   ],
                    // ),
                    // Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                    // Row(
                    //   children: <Widget>[
                    //     Icon(FontAwesomeIcons.youtube),
                    //     SizedBox(width: 20.0),
                    //     Text('')
                    //   ],
                    // ),
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
