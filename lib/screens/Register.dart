import 'package:flutter/material.dart';
import 'package:supervisory/animations/FadeIn.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:supervisory/screens/Entry.dart';
import 'package:supervisory/components/OrDivider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  Padding _formInputPadding() {
    return Padding(padding: EdgeInsets.symmetric(vertical: 7.0));
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
                margin: EdgeInsets.only(top: 15.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    // FadeIn(
                    //   1.0,
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 70.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo.jpg"),
                          ),
                        ),
                      ),
                    // ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    // FadeIn(
                    //   1.1,
                      Text(
                        'Tasty Homes',
                        style: TextStyle(
                          color: Color.fromRGBO(28, 161, 239, 1),
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    // ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
                child: 
                // FadeIn(
                //   1.1,
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: email,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.emailAddress,
                          // toolbarOptions: ToolbarOptions(
                          //   copy: true,
                          //   selectAll: true,
                          //   paste: true,
                          // ),
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
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                        ),
                        _formInputPadding(),
                        TextFormField(
                          controller: name,
                          // toolbarOptions: ToolbarOptions(
                          //   copy: true,
                          //   selectAll: true,
                          //   paste: true,
                          // ),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 5.0),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) return 'Please enter your name';
                            return null;
                          },
                        ),
                        _formInputPadding(),
                        TextFormField(
                          controller: password,
                          textAlignVertical: TextAlignVertical.center,
                          // toolbarOptions:
                          //     ToolbarOptions(paste: false, copy: false),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 5.0),
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
                            if (value!.isEmpty)
                              return 'Please enter your password';
                            return null;
                          },
                        ),
                        _formInputPadding(),
                        TextFormField(
                          controller: phone,
                          maxLength: 10,
                          textAlignVertical: TextAlignVertical.center,
                          // buildCounter : (BuildContext context,
                          //         {int currentLength,
                          //         int maxLength,
                          //         bool isFocused}) =>
                          //     null,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: false),
                          // toolbarOptions: ToolbarOptions(
                          //   copy: true,
                          //   selectAll: true,
                          //   paste: true,
                          // ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 5.0),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please enter phone number';
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: ElevatedButton(
                              // color: Color.fromRGBO(28, 161, 239, 1),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {}
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
                // ),
              ),
              // FadeIn(1.3, 
              OrDivider(),
              // ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: 
                // FadeIn(
                //   1.4,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SignInButton(
                        Buttons.GoogleDark,
                        text: "Sign Up with Google",
                        onPressed: () {},
                      ),
                      SignInButton(
                        Buttons.Facebook,
                        text: "Sign Up with Facebook",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
