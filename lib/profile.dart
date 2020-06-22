import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// class Profile extends StatefulWidget {
//   Profile({Key key, this.firebaseUser}) : super(key: key);
//   final FirebaseUser firebaseUser;
//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   String count = "0";
//   bool recipeFlag = false;
//   bool userFlag = false;
//   User user;

//   @override
//   void initState() {
//     super.initState();
//     Firestore.instance
//         .collection('users')
//         .where('email', isEqualTo: widget.firebaseUser.email)
//         .getDocuments()
//         .then((QuerySnapshot queryDocs) {
//       if (queryDocs.documents.isNotEmpty) {
//         var data = queryDocs.documents[0].data;
//         user = User(
//           name: data['name'],
//           email: data['email'],
//           followers: data['followers'],
//           following: data['following'],
//           bio: data['bio'],
//           joinedDate: data['joinedDate'],
//           speciality: data['speciality'],
//           youtube: data['youtube'],
//           facebook: data['facebook'],
//           instagram: data['instagram'],
//         );
//       }
//       setState(() {
//         userFlag = true;
//       });
//     });

//     RecipeService()
//         .getUserRecipes(widget.firebaseUser.displayName)
//         .then((QuerySnapshot queryDocs) {
//       if (queryDocs.documents.isNotEmpty) {
//         count = queryDocs.documents.length.toString();
//       }
//       setState(() {
//         recipeFlag = true;
//       });
//     });
//   }

//   Widget _buildCoverImage(Size size) {
//     return Container(
//       height: size.height / 4.5,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/images/profile-background.jpg'),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileImage() {
//     return Center(
//       child: Container(
//         width: 140.0,
//         height: 140.0,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: NetworkImage(widget.firebaseUser.photoUrl),
//             fit: BoxFit.cover,
//           ),
//           borderRadius: BorderRadius.circular(80.0),
//           border: Border.all(
//             color: Colors.deepPurple,
//             width: 5.0,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFullName() {
//     TextStyle _nameTextStyle = TextStyle(
//       fontFamily: 'Roboto',
//       color: Colors.black,
//       fontSize: 28.0,
//       fontWeight: FontWeight.w700,
//     );
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
//       decoration: BoxDecoration(
//         color: Theme.of(context).scaffoldBackgroundColor,
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       child: Text(
//         widget.firebaseUser.displayName,
//         style: _nameTextStyle,
//       ),
//     );
//   }

//   Widget _buildStatus(BuildContext context, String speciality) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
//       decoration: BoxDecoration(
//         color: Theme.of(context).scaffoldBackgroundColor,
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       child: Text(
//         speciality,
//         style: TextStyle(
//           fontFamily: 'Roboto',
//           color: Colors.black,
//           fontSize: 20.0,
//           fontWeight: FontWeight.w300,
//         ),
//       ),
//     );
//   }

//   Widget _buildStatItem(String label, String count) {
//     TextStyle _statLabelTextStyle = TextStyle(
//       fontFamily: 'Roboto',
//       color: Colors.black,
//       fontSize: 15.0,
//       fontWeight: FontWeight.w200,
//     );
//     TextStyle _statCountTextStyle = TextStyle(
//       color: Colors.black54,
//       fontSize: 20.0,
//       fontWeight: FontWeight.bold,
//     );

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text(
//           count,
//           style: _statCountTextStyle,
//         ),
//         Text(
//           label,
//           style: _statLabelTextStyle,
//         ),
//       ],
//     );
//   }

//   Widget _buildStatContainer() {
//     return Container(
//       height: 60.0,
//       margin: EdgeInsets.only(top: 8.0),
//       decoration: BoxDecoration(
//         color: Color(0xFFEFF4F7),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           userFlag == true
//               ? _buildStatItem('Followers', user.followers.toString())
//               : CircularProgressIndicator(),
//           userFlag == true
//               ? _buildStatItem('Following', user.following.toString())
//               : CircularProgressIndicator(),
//           recipeFlag == true
//               ? _buildStatItem('Recipes', count)
//               : CircularProgressIndicator(),
//         ],
//       ),
//     );
//   }

//   Widget _buildBio(BuildContext context, String bio) {
//     TextStyle _bioTextStyle = TextStyle(
//       fontFamily: 'Spectral',
//       fontWeight: FontWeight.w500,
//       fontStyle: FontStyle.italic,
//       color: Color(0xFF799497),
//       fontSize: 16.0,
//     );

//     return Container(
//       color: Theme.of(context).scaffoldBackgroundColor,
//       padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
//       child: Text(
//         bio,
//         textAlign: TextAlign.center,
//         style: _bioTextStyle,
//       ),
//     );
//   }

//   Widget _buildSeparator(Size size) {
//     return Container(
//       width: size.width / 1.6,
//       height: 2.0,
//       color: Colors.black54,
//       margin: EdgeInsets.only(top: 2.0),
//     );
//   }

//   Widget _buildGetInTouch(BuildContext context) {
//     return Container(
//       color: Theme.of(context).scaffoldBackgroundColor,
//       padding: EdgeInsets.only(top: 8.0),
//       child: Text(
//         'Get in Touch with ${widget.firebaseUser.displayName.split(' ')[0]}',
//         style: TextStyle(
//           fontFamily: 'Roboto',
//           fontSize: 16.0,
//         ),
//       ),
//     );
//   }

//   Widget _buildButtons() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: InkWell(
//               onTap: () => print('Followed'),
//               child: Container(
//                 height: 40.0,
//                 decoration: BoxDecoration(
//                   border: Border.all(),
//                   color: Colors.deepPurple,
//                 ),
//                 child: Center(
//                   child: Text(
//                     'FOLLOW',
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 18.0,
//           ),
//           Expanded(
//             child: InkWell(
//               onTap: () => print('Unfollowed'),
//               child: Container(
//                 height: 40.0,
//                 decoration: BoxDecoration(
//                   border: Border.all(),
//                   color: Colors.red,
//                 ),
//                 child: Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: Text(
//                       'UNFOLLOW',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: userFlag && recipeFlag
//           ? Stack(
//               children: <Widget>[
//                 _buildCoverImage(size),
//                 SafeArea(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: <Widget>[
//                         SizedBox(
//                           height: size.height / 8.0,
//                         ),
//                         _buildProfileImage(),
//                         _buildFullName(),
//                         user.speciality == ''
//                             ? _buildStatus(context, 'No speciality provided.')
//                             : _buildStatus(context, user.speciality),
//                         _buildStatContainer(),
//                         SizedBox(height: 5),
//                         user.bio == ''
//                             ? _buildBio(context, 'No bio provided.')
//                             : _buildBio(context, user.bio),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Padding(padding: EdgeInsets.only(left: 50.0)),
//                             Icon(FontAwesomeIcons.youtube),
//                             Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 5.0)),
//                             user.youtube == 'Not provided'
//                                 ? Text(user.youtube)
//                                 : RichText(
//                                     text: TextSpan(
//                                       text: user.youtube,
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontFamily: 'Roboto'),
//                                       recognizer: TapGestureRecognizer()
//                                         ..onTap = () {
//                                           launch(user.youtube);
//                                         },
//                                     ),
//                                   ),
//                           ],
//                         ),
//                         Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Padding(padding: EdgeInsets.only(left: 50.0)),
//                             Icon(FontAwesomeIcons.facebookSquare),
//                             Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 5.0)),
//                             RichText(
//                               text: TextSpan(
//                                 text: user.facebook,
//                                 style: TextStyle(
//                                     color: Colors.black, fontFamily: 'Roboto'),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     launch(user.facebook);
//                                   },
//                               ),
//                             ),
//                           ],
//                         ),
//                         Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Padding(padding: EdgeInsets.only(left: 50.0)),
//                             Icon(FontAwesomeIcons.instagram),
//                             Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 5.0)),
//                             RichText(
//                               text: TextSpan(
//                                 text: user.instagram,
//                                 style: TextStyle(
//                                     color: Colors.black, fontFamily: 'Roboto'),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     launch(user.instagram);
//                                   },
//                               ),
//                             ),
//                           ],
//                         ),

//                         // _buildSeparator(size),
//                         // SizedBox(
//                         //   height: 10.0,
//                         // ),
//                         // _buildGetInTouch(context),
//                         // SizedBox(
//                         //   height: 8.0,
//                         // ),
//                         // _buildButtons(),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             )
//           : Container(
//               child: Center(
//                 child: Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 20.0, vertical: 75.0),
//                   child: Column(
//                     children: <Widget>[
//                       CircularProgressIndicator(),
//                       Padding(padding: EdgeInsets.symmetric(vertical: 20.0)),
//                       Text(
//                         'Loading Your Profile....',
//                         style: TextStyle(fontSize: 16.0),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }

class Profile extends StatefulWidget {
  Profile({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //Circular Image
  Positioned _profileImage(String img) {
    return Positioned(
      top: 0.0,
      left: 100.0,
      child: Container(
          width: 160.0,
          height: 160.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.fill, image: new NetworkImage(img)))),
    );
  }

  _openURL() async {
    const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _linkedinURL(String $profileName) async {
    var url = 'https://linkedin.com/' + $profileName;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _twitterURL(String $profileName) async {
    var url = 'https://twitter.com/' + $profileName;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _facebookURL(String $profileName) async {
    var url = 'https://facebook.com/' + $profileName;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _youtubeURL(String $profileName) async {
    var url = 'https://youtube.com/' + $profileName;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //Center Widget
  Center profilePage(String profileName, String jobDescription, String location,
      String followerVal, String webLink) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 300.0,
          height: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Color(0xffffffff),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Text(
                      profileName,
                      style: TextStyle(
                          color: new Color(0xff662d8c),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      jobDescription,
                      style: TextStyle(
                          color: new Color(0xffed1e79), fontSize: 16.0),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.mapMarker,
                                color: Color(0xffed1e79), size: 18.0),
                            SizedBox(width: 10.0),
                            InkWell(
                              child: Text(
                                location,
                                style: TextStyle(
                                    color: new Color(0xff662d8c),
                                    fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            FavoriteWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.link,
                          color: Color(0xffed1e79), size: 18.0),
                      SizedBox(width: 10.0),
                      InkWell(
                        child: Text(
                          webLink,
                          style: TextStyle(
                              color: new Color(0xff662d8c), fontSize: 16.0),
                        ),
                        onTap: () {
                          _openURL();
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Material(
                                color: new Color(0xffffffff),
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(FontAwesomeIcons.facebook,
                                      color: Color(0xff125DDE), size: 35.0),
                                )),
                            onTap: () {
                              _facebookURL("girish");
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Material(
                                color: new Color(0xffffffff),
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(FontAwesomeIcons.youtube,
                                      color: Colors.red, size: 35.0),
                                )),
                            onTap: () {
                              _youtubeURL("girish");
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Material(
                                color: new Color(0xffffffff),
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(FontAwesomeIcons.twitter,
                                      color: Color.fromRGBO(8, 160, 233, 1),
                                      size: 35.0),
                                )),
                            onTap: () {
                              _twitterURL("girish");
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Material(
                                color: new Color(0xffffffff),
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(FontAwesomeIcons.linkedin,
                                      color: Color.fromRGBO(0, 119, 181, 1),
                                      size: 35.0),
                                )),
                            onTap: () {
                              _linkedinURL("girish");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [
                    const Color(0xff662d8c),
                    const Color(0xffed1e79),
                  ],
                  begin: Alignment.centerRight,
                  end: new Alignment(-1.0, -1.0),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  profilePage(
                      "", "Italian Chef", "India", "200", "www.google.com"),
                  ProfileImageWidget(firebaseUser: widget.firebaseUser),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 100;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: IconButton(
            icon: (_isFavorited
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border)),
            color: Color(0xffed1e79),
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 35,
          child: Container(
            child: Text(
              '$_favoriteCount',
              style: TextStyle(color: new Color(0xff662d8c), fontSize: 18.0),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileImageWidget extends StatefulWidget {
  ProfileImageWidget({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  var height = 120.0;
  var width = 120.0;
  var shape = BoxShape.circle;

  void _changeShape() {
    setState(() {
      shape = BoxShape.rectangle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60.0,
      left: 115.0,
      child: GestureDetector(
        onTap: () {
          print('image clicked');
          _changeShape();
        },
        child: Container(
          width: width,
          height: height,
          decoration: new BoxDecoration(
            shape: shape,
            image: new DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage(widget.firebaseUser.photoUrl),
            ),
          ),
        ),
      ),
    );
  }
}
