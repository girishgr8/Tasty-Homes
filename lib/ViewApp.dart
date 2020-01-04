import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/walkthrough.dart';
import 'package:flutter_walkthrough/flutter_walkthrough.dart';
import 'package:supervisory/Dashboard.dart';

class ViewApp extends StatelessWidget {
  final FirebaseUser firebaseUser;
  ViewApp({this.firebaseUser});

  final List<Walkthrough> list = [
    Walkthrough(
      title: 'New Recipes',
      content:
          'Add new recipes by publishing them and helping newbies to learn making them.',
      imageIcon: Icons.add,
      imagecolor: Colors.deepPurple,
    ),
    Walkthrough(
      title: 'Search Recipes',
      content: 'Search for recipes by their dish names.',
      imageIcon: Icons.search,
      imagecolor: Colors.deepPurple,
    ),
    Walkthrough(
      title: 'Filter Recipes',
      content:
          'Search for recipes based on parameters like preparation time, published date, likes, read time.',
      imageIcon: Icons.filter_list,
      imagecolor: Colors.deepPurple,
    ),
    Walkthrough(
      title: 'Lets\'s go !',
      content: 'Start creating your recipes.',
      imageIcon: Icons.arrow_forward,
      imagecolor: Colors.deepPurple,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return IntroScreen(
        list,
        MaterialPageRoute(
            builder: (context) => DashboardPage(firebaseUser: firebaseUser)));
  }
}
