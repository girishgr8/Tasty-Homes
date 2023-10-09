import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeService {
  Stream<QuerySnapshot> getRecipes() {
    return FirebaseFirestore.instance.collection('recipes').snapshots();
  }

  getSingleRecipe(String id) {
    return FirebaseFirestore.instance.collection('recipes/$id').snapshots();
  }
}
