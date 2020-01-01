import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeService {
  String chef, recipeName, procedure, prepTime, readTime;
  int likes;
  DateTime pub_date;
  RecipeService({
    this.chef,
    this.recipeName,
    this.prepTime,
    this.readTime,
    this.procedure,
    this.likes,
    this.pub_date,
  });

  getUserRecipes(String chef) {
    return Firestore.instance
        .collection('recipes')
        .where('chef', isEqualTo: chef)
        .orderBy('pub_date', descending: true)
        .getDocuments();
  }

  addNewRecipe() {
    return Firestore.instance.collection("recipes").document().setData({
      "chef": chef,
      "recipeName": recipeName,
      "prepTime": prepTime,
      "readTime": readTime,
      "procedure": procedure,
      "likes": likes,
      "pub_date": pub_date,
    });
  }
}
