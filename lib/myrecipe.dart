import 'package:flutter/material.dart';

class MyRecipePage extends StatefulWidget {
  @override
  _MyRecipePageState createState() => _MyRecipePageState();
}

class _MyRecipePageState extends State<MyRecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Recipes'),
        centerTitle: true,
      ),
      body: Center(child: Column()),
    );
  }
}
