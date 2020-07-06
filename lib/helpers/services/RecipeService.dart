import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeService {
  Stream<QuerySnapshot> getRecipes() {
    return Firestore.instance.collection('recipes').snapshots();
  }

  getSingleRecipe(String id) {
    return Firestore.instance.collection('recipes/$id').snapshots();
  }
}
