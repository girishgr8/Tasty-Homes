import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';
import 'package:supervisory/screens/Dashboard.dart';
import 'package:supervisory/screens/Profile.dart';

class AppIntro extends StatelessWidget {
  final User firebaseUser;
  AppIntro({required this.firebaseUser});

  // final List<PageViewModel> walkThroughPages = [
  //   PageViewModel(
  //       title: 'New Recipes',
  //       body:
  //           'Add new recipes by publishing them and helping newbies to learn making them.',
  //       image: const Center(
  //         child: Icon(Icons.waving_hand, size: 50.0),
  //       )
  //       // imageIcon: Icons.add,
  //       // imagecolor: Colors.deepPurple,
  //       ),
  //   PageViewModel(
  //     title: 'Search Recipes',
  //     body: 'Search for recipes by their dish names.',
  //     image: const Center(
  //       child: Icon(Icons.waving_hand, size: 50.0),
  //     ),
  //     // imageIcon: Icons.search,
  //     // imagecolor: Colors.deepPurple,
  //   ),
  //   PageViewModel(
  //     title: 'Filter Recipes',
  //     body:
  //         'Search for recipes based on parameters like preparation time, published date, likes, read time.',
  //     image: const Center(
  //       child: Icon(Icons.waving_hand, size: 50.0),
  //     ),
  //     // imageIcon: Icons.filter_list,
  //     // imagecolor: Colors.deepPurple,
  //   ),
  //   PageViewModel(
  //     title: 'Lets\'s go !',
  //     body: 'Start creating your recipes.',
  //     image: const Center(
  //       child: Icon(Icons.waving_hand, size: 50.0),
  //     ),
  //     // imageIcon: Icons.arrow_forward,
  //     // imagecolor: Colors.deepPurple,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    // IntroductionScreen(
    //   pages: walkThroughPages,
    //   showSkipButton: true,
    //   showNextButton: false,
    //   skip: const Text("Skip"),
    //   done: const Text("Done"),
    //   onDone: () => {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => Dashboard(firebaseUser: firebaseUser)))
    //   },
    // );
    return Dashboard(appUser: null, firebaseUser: firebaseUser);
  }
}
