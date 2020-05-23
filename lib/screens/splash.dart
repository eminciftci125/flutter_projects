import 'dart:core';
import 'dart:async';
import 'package:burayabakarlar/values/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: new Container(child: widget.image),
                        radius: widget.photoSize,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      widget.title
                    ],
                  )),
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
                        : AnimatedContainer(
                            curve: Curves.easeOut,
                            duration: Duration(
                              milliseconds: 400,
                            ),
                            width: double.infinity,
                            height: double.infinity,
                            alignment: _childAlignment,
                            child: new Container(
                              padding: EdgeInsets.all(40),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: _usernameController,
                                      autofocus: false,
                                      validator: (value) =>
                                          validateEmail(value) == null
                                              ? 'Invalid email'
                                              : null,
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        icon: new Icon(
                                          Icons.mail,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      controller: _passwordController,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        hintText: "Şifre",
                                        icon: new Icon(
                                          Icons.lock,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 30.0),
                                      child: RaisedButton(
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    30.0)),
                                        color: Colors.white,
                                        onPressed: () {
                                          validateAndLogin();
                                        },
                                        child: Text('Giriş Yap'),
                                      ),
                                    ),
                                    _keyboardOpen == false
                                        ? Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 50.0),
                                              child: FlatButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    //showProgress = true;
                                                  });
                                                  try {
                                                    await _auth
                                                        .createUserWithEmailAndPassword(
                                                            email:
                                                                _usernameController
                                                                    .text,
                                                            password:
                                                                _passwordController
                                                                    .text);

                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    prefs.setString(
                                                        'email',
                                                        _usernameController
                                                            .text);
                                                  } catch (e) {}
                                                },
                                                child: Text(
                                                  'Kaydol',
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
