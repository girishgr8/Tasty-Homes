import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supervisory/helpers/classes/User.dart';

class UserService {
  getUser(String email) {
    return Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();
    // .snapshots()
    // .listen((QuerySnapshot snapshot) {});
  }

  Stream<QuerySnapshot> getUserData(FirebaseUser user) {
    return Firestore.instance
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .snapshots();
  }

  Future<void> addUser(FirebaseUser user) {
    return Firestore.instance.collection("users").document().setData({
      "uid": user.uid,
      "name": user.displayName,
      "email": user.email,
      "liked": [],
      "joinDate": DateTime.now(),
      "photo": user.photoUrl,
      "phone": user.phoneNumber,
      "saved": [],
    });
  }

  Future<void> addLikedRecipe(String userDocId, List<dynamic> liked) {
    return Firestore.instance
        .collection("users")
        .document(userDocId)
        .updateData({"liked": liked});
  }

  Future<void> addSavedRecipe(String userDocId, List<dynamic> saved) {
    return Firestore.instance
        .collection("users")
        .document(userDocId)
        .updateData({"saved": saved});
  }
}
