import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supervisory/screens/SplashScreen.dart';

void main() => runApp(TastyHomes());

class TastyHomes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasty Homes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: debugDefaultTargetPlatformOverride == TargetPlatform.iOS
              ? Colors.grey[50]
              : null),
      home: SplashScreen(),
    );
  }
}
