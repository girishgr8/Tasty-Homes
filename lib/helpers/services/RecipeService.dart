import 'package:cloud_firestore/cloud_firestore.dart';


class RecipeService {
  getUserRecipes() {
    return Firestore.instance.collection('recipes').getDocuments();
    // .where('chef', isEqualTo: chef)
    // .orderBy('pubDate', descending: true)
  }

  // getAllRecipes() {
  //   return Firestore.instance
  //       .collection('recipes')
  //       .orderBy('pubDate', descending: true)
  //       .orderBy('likes', descending: true)
  //       .limit(50)
  //       .getDocuments();
  // }

  // addNewRecipe(Recipe recipe) {
  //   return Firestore.instance.collection("recipes").document().setData({
  //     "chef": recipe.chef,
  //     "recipeName": recipe.recipeName,
  //     "prepTime": recipe.prepTime,
  //     "readTime": recipe.readTime,
  //     "procedure": recipe.procedure,
  //     "likes": recipe.likes,
  //     "ingredients": recipe.ingredients,
  //     "pubDate": recipe.pubDate,
  //   });
  // }

  getSingleRecipe(String id) {
    return Firestore.instance.collection('recipes/$id').snapshots();
  }
}
