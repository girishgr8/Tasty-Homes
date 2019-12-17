import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supervisory/dashboard.dart';
import 'package:supervisory/events.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supervisory/navDrawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            primaryColor:
                debugDefaultTargetPlatformOverride == TargetPlatform.iOS
                    ? Colors.grey[50]
                    : null),
        home: MyHomePage(title: 'Supervisory Manager'),
        initialRoute: '/',
        routes: {
          '/events': (context) => EventsPage(
                title: 'Events Page',
              ),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      drawer: MyNavDrawer(
        firebaseUser: null,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Landing Page'),
            ],
          ),
        ),
      ),
    );
  }
}

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    print("Signed in, Username is: " + user.displayName);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        drawer: MyNavDrawer(
          firebaseUser: null,
        ),
        body: Container(
          padding: EdgeInsets.all(85),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.all(15),
                  onPressed: () => _signIn().then((FirebaseUser fireUser) {
                    print('User ${fireUser.displayName} signed in');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              new DashboardPage(firebaseUser: fireUser),
                        ));
                  }).catchError((err) => print(err)),
                  child: Text('Google Sign In'),
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ));
  }
}
