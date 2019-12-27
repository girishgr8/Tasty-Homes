import 'package:flutter/material.dart';

class MyRecipePage extends StatefulWidget {
  @override
  MyRecipePage({Key key, this.title}) : super(key: key);

  final String title;
  _MyRecipePageState createState() => _MyRecipePageState();
}

class _MyRecipePageState extends State<MyRecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(child: Column()),
    );
  }
}
