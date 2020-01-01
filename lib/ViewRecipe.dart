import 'package:flutter/material.dart';
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
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: Card(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/profile-background.jpg'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(vertical: 20.0)),
                      Center(
                        child: Text(
                          '${recipe.recipeName}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
