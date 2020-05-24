import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'constants.dart';
import 'package:burayabakarlar/custom_themes.dart';

import 'main.dart';

class Login extends StatefulWidget {
  const Login({
    Key key,
  }) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController;
  TextEditingController usernameController;
  TextEditingController passwordController;
  TextEditingController passwordConfirmationController;
  Constants constants;
  bool keyboardOpen = false;
  //0: Login page , 1: Register page, 2: Forgot password page
  int _currentPage = 0;

  @override
  initState() {
    nameController = new TextEditingController();
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
    passwordConfirmationController = new TextEditingController();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          keyboardOpen = visible;
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void backToLogin() {
      setState(() {
        _currentPage = 0;
      });
    }

    if (_currentPage == 0) {
      return Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: loginPage(),
        ),
      );
    }

    if (_currentPage == 1) {
      return Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: registerPage(),
        ),
      );
    }

    if (_currentPage == 2) {
      return Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: forgotPasswordPage(),
        ),
      );
    }
  }

  Column loginPage() {
    return Column(
      mainAxisAlignment:
          keyboardOpen ? MainAxisAlignment.start : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        customLoginTextField(
            usernameController, Constants.EMAIL, Icons.mail, false),
        SizedBox(
          height: 20,
        ),
        customLoginTextField(
            passwordController, Constants.PASSWORD, Icons.lock, true),
        primaryButtons(Constants.LOGIN),
        keyboardOpen == true
            ? Container()
            : Column(
                children: <Widget>[
                  secondaryButtons(Constants.REGISTER, 1),
                  secondaryButtons(Constants.FORGOT_MY_PASSWORD, 2)
                ],
              )
      ],
    );
  }

  Column registerPage() {
    return Column(
      mainAxisAlignment:
          keyboardOpen ? MainAxisAlignment.start : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        customLoginTextField(
            nameController, Constants.NAME, Icons.account_box, false),
        SizedBox(
          height: 20,
        ),
        customLoginTextField(
            usernameController, Constants.EMAIL, Icons.mail, false),
        SizedBox(
          height: 20,
        ),
        customLoginTextField(
            passwordController, Constants.PASSWORD, Icons.lock, true),
        SizedBox(
          height: 20,
        ),
        customLoginTextField(passwordController,
            Constants.PASSWORD_CONFIRMATION, Icons.lock, true),
        primaryButtons(Constants.REGISTER),
        keyboardOpen == true
            ? Container()
            : secondaryButtons(Constants.BACK_TO_LOGIN, 0)
      ],
    );
  }

  Column forgotPasswordPage() {
    return Column(
      mainAxisAlignment:
          keyboardOpen ? MainAxisAlignment.start : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        customLoginTextField(
            usernameController, Constants.EMAIL, Icons.mail, false),
        primaryButtons(Constants.RESET_PASSWORD),
        keyboardOpen == true
            ? Container()
            : secondaryButtons(Constants.BACK_TO_LOGIN, 0)
      ],
    );
  }

  Padding primaryButtons(String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          color: white,
          onPressed: () {
            if (type == Constants.SUBMIT) {
              validateAndSubmit();
              clearFields();
            }

            if (type == Constants.LOGIN) {
              validateAndLogin();
            }

            if (type == Constants.RESET_PASSWORD) {
              validateAndResetPassword();
            }
          },
          child: Text(type)),
    );
  }

  TextFormField customLoginTextField(TextEditingController _controller,
      String _hintText, IconData _iconData, bool _obscureText) {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: _obscureText,
      controller: _controller,
      autofocus: false,
      validator: (text) {
        if (_hintText == Constants.EMAIL) {
          return validateEmail(text);
        }

        if (_hintText == Constants.PASSWORD) {
          return validatePassword(text);
        }

        if (_hintText == Constants.NAME) {
          return validateName(text);
        }

        if (_hintText == Constants.PASSWORD_CONFIRMATION) {
          return validatePasswordConfirmation(text);
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: _hintText,
        icon: Icon(
          _iconData,
          color: loginIconsColor,
        ),
      ),
    );
  }

  Container secondaryButtons(String text, int pageNumber) {
    return Container(
      child: Padding(
        padding: text == Constants.FORGOT_MY_PASSWORD
            ? const EdgeInsets.all(5)
            : const EdgeInsets.symmetric(vertical: 0.0),
        child: FlatButton(
          onPressed: () {
            setState(() {
              _currentPage = pageNumber;
            });
          },
          child: Text(text),
        ),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern = Constants.VALID_MAIL_PATTERN;
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return Constants.MSG_INVALID_EMAIL;
    }

    return null;
  }

  String validatePassword(String value) {
    if (value.length < 6 || value.length > 16) {
      return Constants.INVALID_PASSWORD;
    }
    return null;
  }

  String validateName(String value) {
    if (value.length == 0) {
      return Constants.EMPTY_NAME;
    } else if (value.length > 20) {
      return Constants.NAME_BOUNDARY;
    }

    return null;
  }

  String validatePasswordConfirmation(String value) {
    if (value != passwordController.text) {
      return Constants.PASSWORD_MATCH_ERROR;
    }

    return null;
  }

  void clearFields() {
    setState(() {
      usernameController.text = "";
      passwordController.text = "";
      passwordConfirmationController.text = "";
      nameController.text = "";
    });
  }

  void validateAndResetPassword() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());

      if (!_formKey.currentState.validate()) {
        return;
      }

      await _auth.sendPasswordResetEmail(email: usernameController.text);

      clearFields();
      Fluttertoast.showToast(msg: Constants.RESET_LINK_SENT);
    } catch (e) {
      if (e.code == Constants.USER_NOT_FOUND) {
        Fluttertoast.showToast(msg: Constants.MSG_EMAIL_NOT_FOUND);
      }
    }
  }

  void validateAndLogin() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());

      if (!_formKey.currentState.validate()) {
        return;
      }
      var _authUser = await _auth.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);

      print(_authUser);
    } catch (e) {
      switch (e.code) {
        case Constants.INVALID_EMAIL:
          {
            Fluttertoast.showToast(msg: Constants.MSG_INVALID_EMAIL);
            break;
          }
        case Constants.USER_NOT_FOUND:
          {
            Fluttertoast.showToast(msg: Constants.MSG_USER_NOT_FOUND);
            break;
          }
        case Constants.WRONG_PASSWORD:
          {
            Fluttertoast.showToast(msg: Constants.MSG_WRONG_PASSWORD);
            break;
          }
        default:
          Fluttertoast.showToast(msg: Constants.MSG_ERROR_OCCURED);
      }
    }
  }

  void validateAndSubmit() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());

      if (!_formKey.currentState.validate()) {
        return;
      }

      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);

      print(result);
    } catch (e) {}
  }
}

class Welcome {}
