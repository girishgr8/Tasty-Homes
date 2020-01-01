import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supervisory/Dashboard.dart';
import 'package:supervisory/services/RecipeService.dart';

class NewRecipe extends StatefulWidget {
  NewRecipe({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _NewRecipeState createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
  final recipeName = TextEditingController();
  final prepTime = TextEditingController();
  final readTime = TextEditingController();
  final procedure = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File _image;
  Future pickImageFromGallery(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      _image = image;
    });
  }

  void _addRecipe(BuildContext context) {
    RecipeService(
      chef: widget.firebaseUser.displayName,
      recipeName: recipeName.text,
      prepTime: prepTime.text,
      readTime: readTime.text,
      procedure: procedure.text,
      likes: 0,
      pubDate: DateTime.now(),
    ).addNewRecipe().whenComplete(() {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            titleTextStyle: TextStyle(
              fontSize: 18.0,
              color: Colors.deepPurple,
            ),
            title: Text('Successful !'),
            elevation: 30.0,
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DashboardPage(firebaseUser: widget.firebaseUser),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }).catchError((err) {
      print(err);
    });
  }

  void _deleteRecipe() {}
  void _updateRecipe() {}
  void _fetchRecipe() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Recipe'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Card(
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: recipeName,
                      decoration: const InputDecoration(
                        hasFloatingPlaceholder: true,
                        labelText: 'Dish Name',
                        prefixIcon: Icon(FontAwesomeIcons.cookieBite),
                        labelStyle: TextStyle(fontSize: 16.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0))),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter dish name';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    TextFormField(
                      controller: prepTime,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: false),
                      decoration: const InputDecoration(
                        hasFloatingPlaceholder: true,
                        labelText: 'Preparation Time',
                        prefixIcon: Icon(FontAwesomeIcons.solidClock),
                        suffixText: 'minutes',
                        labelStyle: TextStyle(fontSize: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter preparation time';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    TextFormField(
                      controller: readTime,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: false),
                      decoration: const InputDecoration(
                        hasFloatingPlaceholder: true,
                        labelText: 'Read Time',
                        prefixIcon: Icon(FontAwesomeIcons.solidClock),
                        suffixText: 'minutes',
                        labelStyle: TextStyle(fontSize: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter read time for procedure';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    TextFormField(
                      controller: procedure,
                      minLines: 5,
                      maxLines: 500,
                      toolbarOptions: ToolbarOptions(
                        copy: true,
                        selectAll: true,
                        paste: true,
                        cut: true,
                      ),
                      decoration: const InputDecoration(
                        hasFloatingPlaceholder: true,
                        labelText: 'Procedure',
                        labelStyle: TextStyle(fontSize: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter procedure for dish';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Center(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                'Add Image',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.images,
                                ),
                                tooltip: 'Choose from Gallery',
                                onPressed: () =>
                                    pickImageFromGallery(ImageSource.gallery),
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.camera,
                                  ),
                                  onPressed: () {
                                    pickImageFromGallery(ImageSource.camera);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.deepPurple,
                                  padding: EdgeInsets.symmetric(vertical: 12.0),
                                  onPressed: () {
                                    // Validate will return true if the form is valid, or false if
                                    // the form is invalid.
                                    if (_formKey.currentState.validate()) {
                                      // Process data.
                                      _addRecipe(context);
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 35.0,
                              ),
                              Expanded(
                                child: RaisedButton(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.red,
                                  padding: EdgeInsets.symmetric(vertical: 12.0),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          titleTextStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.deepPurple,
                                          ),
                                          title: Text('Cancel New Recipe ?'),
                                          elevation: 30.0,
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('YES'),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DashboardPage(
                                                            firebaseUser: widget
                                                                .firebaseUser),
                                                  ),
                                                );
                                              },
                                            ),
                                            FlatButton(
                                              child: Text('NO'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
