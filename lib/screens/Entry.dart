import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supervisory/helpers/services/UserService.dart';
import 'package:supervisory/screens/Dashboard.dart';
import 'package:supervisory/screens/AppIntro.dart';
import 'package:supervisory/animations/FadeIn.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:supervisory/screens/Register.dart';
import 'package:supervisory/components/OrDivider.dart';
// import 'package:supervisory/auth/Auth.dart';

class EntryScreen extends StatefulWidget {
  // EntryScreen({this.auth});
  // final Auth auth;
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

enum AuthStatus { NOT_LOGIN, NOT_DETERMINED, LOGIN }

class _EntryScreenState extends State<EntryScreen> {
  // AuthStatus _authStatus = AuthStatus.NOT_DETERMINED;
  // FirebaseUser _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;

  // @override
  // void initState() {
  //   super.initState();
  //   widget.auth.getCurrentUser().then((user) {
  //     if (user != null) _user = user;

  //     _authStatus = user?.uid == null ? AuthStatus.NOT_LOGIN : AuthStatus.LOGIN;
  //   });
  // }

  Future<FirebaseUser> _signIn(BuildContext context) async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;

    // assert(!user.isAnonymous);
    // assert(await user.getIdToken() != null);
    // final FirebaseUser currentUser = await _auth.currentUser();
    // assert(user.uid == currentUser.uid);

    if (authResult.additionalUserInfo.isNewUser) {
      UserService().addUser(user).whenComplete(() {
        print('New User ${user.displayName} added....!');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => AppIntro(firebaseUser: user)),
            (Route<dynamic> route) => false);
      });
    }
    print("Signed in, Username is: " + user.displayName);
    return user;
  }

  // Widget _showLoading() {
  //   return Scaffold(
  //     body: Container(
  //       alignment: Alignment.center,
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  // }

  // void _onSignedIn() {
  //   widget.auth.getCurrentUser().then((user) {
  //     setState(() {
  //       _authStatus = AuthStatus.LOGIN;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // switch (_authStatus) {
    //   case AuthStatus.NOT_DETERMINED:
    //     return _showLoading();
    //   case AuthStatus.NOT_LOGIN:
    //     return _showLogin();
    //   case AuthStatus.LOGIN:
    //     if (_user.uid.length > 0 && _user != null) {
    //       return Dashboard(firebaseUser: _user);
    //     } else {
    //       return _showLoading();
    //     }
    //     break;
    //   default:
    //     return _showLoading();
    //     break;
    // }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    FadeIn(
                      1.0,
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 70.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo.jpg"),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    FadeIn(
                      1.1,
                      Text(
                        'Tasty Homes',
                        style: TextStyle(
                          color: Color.fromRGBO(28, 161, 239, 1),
                          fontSize: 27.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: FadeIn(
                  1.2,
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: email,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.emailAddress,
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            selectAll: true,
                            paste: true,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 5.0),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.mail),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                        TextFormField(
                          controller: password,
                          textAlignVertical: TextAlignVertical.center,
                          toolbarOptions:
                              ToolbarOptions(paste: false, copy: false),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 5.0),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                icon: isVisible
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                }),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                          obscureText: isVisible ? false : true,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please enter your password';
                            return null;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Forgot Password ?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(108, 117, 125, 1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: RaisedButton(
                              color: Color.fromRGBO(28, 161, 239, 1),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {}
                              },
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Don't have an account?",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 5.0),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                );
                              },
                              child: Text(
                                "SIGNUP",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    color: Color.fromRGBO(28, 161, 239, 1),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FadeIn(1.3, OrDivider()),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: FadeIn(
                  1.4,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SignInButton(
                        Buttons.GoogleDark,
                        text: "Sign In with Google",
                        onPressed: () {
                          _signIn(context).then(
                            (FirebaseUser fireUser) {
                              print('User ${fireUser.displayName} signed in');
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Dashboard(firebaseUser: fireUser),
                              ));
                            },
                          ).catchError((err) => print(err));
                        },
                      ),
                      SignInButton(
                        Buttons.Facebook,
                        text: "Sign In with Facebook",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
