import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddReceipe extends StatefulWidget {
  AddReceipe({Key key, this.firebaseUser}) : super(key: key);
  final FirebaseUser firebaseUser;
  @override
  _AddReceipeState createState() => _AddReceipeState();
}

class _AddReceipeState extends State<AddReceipe> {
  final _formKey = GlobalKey<FormState>();

  pickImageFromGallery(ImageSource source) {
    setState(() {
      ImagePicker.pickImage(source: source);
    });
  }

  Widget _buildSmallInputs() {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hasFloatingPlaceholder: true,
                    labelText: 'Dish Name',
                    prefixIcon: Icon(FontAwesomeIcons.cookieBite),
                    labelStyle: TextStyle(fontSize: 16.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
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
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
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
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
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
                RaisedButton.icon(
                  icon: Icon(
                    FontAwesomeIcons.images,
                  ),
                  label: Text('Select image from gallery'),
                  onPressed: () => pickImageFromGallery(ImageSource.gallery),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              // icon: Icon(FontAwesomeIcons.arrowRight),
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
                                  print('Now add to Cloud Store');
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 35.0,
                          ),
                          Expanded(
                            child: RaisedButton(
                              // icon: Icon(FontAwesomeIcons.arrowLeft),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Colors.red,
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              onPressed: () {},
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Recipe'),
          centerTitle: true,
        ),
        body: _buildSmallInputs(),
      ),
    );
  }
}