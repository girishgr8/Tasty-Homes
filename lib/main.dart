import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supervisory/screens/SplashScreen.dart';

void main() => runApp(TastyHomes());

Map<int, Color> color = {
  50: Color.fromRGBO(28, 161, 239, .1),
  100: Color.fromRGBO(28, 161, 239, .2),
  200: Color.fromRGBO(28, 161, 239, .3),
  300: Color.fromRGBO(28, 161, 239, .4),
  400: Color.fromRGBO(28, 161, 239, .5),
  500: Color.fromRGBO(28, 161, 239, .6),
  600: Color.fromRGBO(28, 161, 239, .7),
  700: Color.fromRGBO(28, 161, 239, .8),
  800: Color.fromRGBO(28, 161, 239, .9),
  900: Color.fromRGBO(28, 161, 239, 1),
};

class TastyHomes extends StatelessWidget {
  final MaterialColor colorCustom = MaterialColor(0XFF1CA1EF, color);

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
