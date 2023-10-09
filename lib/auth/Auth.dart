import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<User> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> getCurrentUser() async {
    return _firebaseAuth.currentUser!;
  }

  Future<void> sendEmailVerification() async {
    User firebaseUser = _firebaseAuth.currentUser!;
    firebaseUser.sendEmailVerification();
  }

  Future<String> signIn(String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    User firebaseUser = result.user!;
    return firebaseUser.uid;
  }

  Future<String> signUp(String email, String password) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    User firebaseUser = result.user!;
    return firebaseUser.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<bool> isEmailVerified() async {
    User firebaseUser = _firebaseAuth.currentUser!;
    return firebaseUser.emailVerified;
  }
}
