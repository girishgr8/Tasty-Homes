import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supervisory/screens/Dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supervisory/screens/AppIntro.dart';
import 'package:supervisory/animations/FadeIn.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:supervisory/screens/Entry.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  final phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  Future<FirebaseUser> _signIn(BuildContext context) async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    if (authResult.additionalUserInfo.isNewUser) {
      Firestore.instance.collection("users").document().setData({
        "name": user.displayName,
        "email": user.email,
        "bio": "",
        "joinDate": DateTime.now(),
        "photo": user.photoUrl,
        "phone": user.phoneNumber,
        "saved": 0,
      }).whenComplete(() {
        print('New User ${user.displayName} added....!');

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ViewApp(firebaseUser: user),
            ),
            (Route<dynamic> route) => false);
      });
    }
    print("Signed in, Username is: " + user.displayName);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    FadeIn(
                      1.0,
                      CircleAvatar(
                        backgroundColor: Colors.white24,
                        radius: 60.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 80.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/logo.jpg"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    FadeIn(
                      1.3,
                      Text(
                        'Tasty Homes',
                        style: TextStyle(
                          color: Color.fromRGBO(28, 161, 239, 1),
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: FadeIn(
                  1.5,
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: email,
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            selectAll: true,
                            paste: true,
                          ),
                          decoration: InputDecoration(
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        TextFormField(
                          controller: name,
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            selectAll: true,
                            paste: true,
                          ),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) return 'Please enter your name';
                            return null;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        TextFormField(
                          controller: password,
                          toolbarOptions:
                              ToolbarOptions(paste: false, copy: false),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                icon: isPasswordVisible
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                }),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                          obscureText: isPasswordVisible ? false : true,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please enter your password';
                            return null;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        TextFormField(
                          controller: confirmpassword,
                          toolbarOptions:
                              ToolbarOptions(paste: false, copy: false),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                icon: isConfirmPasswordVisible
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    isConfirmPasswordVisible =
                                        !isConfirmPasswordVisible;
                                  });
                                }),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                          obscureText: isConfirmPasswordVisible ? false : true,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please enter your password to confirm';
                            if (value.toString() != password.value.toString())
                              return "Passwords do not match";
                            return null;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        TextFormField(
                          controller: phone,
                          maxLength: 10,
                          buildCounter: (BuildContext context,
                                  {int currentLength,
                                  int maxLength,
                                  bool isFocused}) =>
                              null,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: false),
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            selectAll: true,
                            paste: true,
                          ),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please enter phone number';
                            return null;
                          },
                        ),
                        SizedBox(height: 15.0),
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
                                "REGISTER",
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
                              "Already have an account?",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 5.0),
                            InkWell(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EntryScreen()),
                                    (route) => false);
                              },
                              child: Text(
                                "LOGIN",
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
              FadeIn(
                1.6,
                Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                          indent: 18.0, endIndent: 8.0, thickness: 1.0)),
                  Text(
                    "OR",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                      child: Divider(
                          indent: 8.0, endIndent: 18.0, thickness: 1.0)),
                ]),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FadeIn(
                      1.7,
                      SignInButton(
                        Buttons.GoogleDark,
                        text: "Sign Up with Google",
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
                    ),
                    FadeIn(
                      1.7,
                      SignInButton(
                        Buttons.Facebook,
                        text: "Sign Up with Facebook",
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
