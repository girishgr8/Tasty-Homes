import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeService {
  String chef, recipeName, procedure, prepTime, readTime;
  int likes;
  var pubDate;
  RecipeService({
    this.chef,
    this.recipeName,
    this.prepTime,
    this.readTime,
    this.procedure,
    this.likes,
    this.pubDate,
  });

  getUserRecipes(String chef) {
    return Firestore.instance
        .collection('recipes')
        .where('chef', isEqualTo: chef)
        .orderBy('pubDate', descending: true)
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
      "pubDate": pubDate,
    });
  }
}
