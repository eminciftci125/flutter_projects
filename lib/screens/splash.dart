import 'dart:core';
import 'dart:async';
import 'package:burayabakarlar/values/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  final int seconds;
  final Text title;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  final dynamic navigateAfterSeconds;
  final double photoSize;
  final dynamic onClick;
  final Color loaderColor;
  final Image image;
  final Text loadingText;
  final ImageProvider imageBackground;
  final Gradient gradientBackground;

  SplashScreen(
      {this.loaderColor,
      @required this.seconds,
      this.photoSize,
      this.onClick,
      this.navigateAfterSeconds,
      this.title = const Text(''),
      this.backgroundColor = Colors.white,
      this.styleTextUnderTheLoader = const TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
      this.image,
      this.loadingText = const Text(""),
      this.imageBackground,
      this.gradientBackground});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = FirebaseAuth.instance;
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  bool _keyboardOpen = false;
  Alignment _childAlignment = Alignment.center;
  bool isLoading = true;

  @override
  void initState() {
    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          _childAlignment = visible ? Alignment.topCenter : Alignment.center;
          _keyboardOpen = visible;
        });
      },
    );

    super.initState();
    Timer(Duration(seconds: widget.seconds), () {
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: widget.imageBackground == null
                    ? null
                    : new DecorationImage(
                        fit: BoxFit.fill,
                        image: widget.imageBackground,
                      ),
                gradient: widget.gradientBackground,
                color: widget.backgroundColor,
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height/2.5,
                        child: new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        widget.image,
                        new Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                        ),
                        widget.title
                      ],
                    )),
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                    child: isLoading
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    widget.loaderColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                              ),
                              widget.loadingText
                            ],
                          )
                        : Login(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  void validateAndLogin() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      var _authUser = await _auth.createUserWithEmailAndPassword(
          email: _usernameController.text, password: _passwordController.text);

      print(_authUser);
    } catch (e) {
      switch (e.code) {
        case "ERROR_INVALID_EMAIL":
          {
            Fluttertoast.showToast(msg: "Invalid email");
            break;
          }
        case "ERROR_USER_NOT_FOUND":
          {
            Fluttertoast.showToast(msg: "Incorrect email/password");
            break;
          }
        default:
          Fluttertoast.showToast(msg: "Email or password can not be empty");
      }
    }
  }
}
