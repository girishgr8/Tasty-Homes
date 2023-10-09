import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  getUser(String email) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    // .snapshots()
    // .listen((QuerySnapshot snapshot) {});
  }

  Future<QuerySnapshot> getUserData(User firebaseUser) async{
    return await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: firebaseUser.uid).get();
  }

  Future<void> addUser(User firebaseUser) {
    return FirebaseFirestore.instance.collection("users").doc().set({
      "uid": firebaseUser.uid,
      "name": firebaseUser.displayName,
      "email": firebaseUser.email,
      "liked": [],
      "joinDate": DateTime.now(),
      "photo": firebaseUser.photoURL,
      "phone": firebaseUser.phoneNumber,
      "saved": [],
    });
  }

  Future<void> addLikedRecipe(String userDocId, List<dynamic> liked) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userDocId)
        .update({"liked": liked});
  }

  Future<void> addSavedRecipe(String userDocId, List<dynamic> saved) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userDocId)
        .update({"saved": saved});
  }
}
