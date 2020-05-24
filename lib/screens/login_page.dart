import 'package:burayabakarlar/screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../values/constants.dart';
import '../values/theme.dart';

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
  bool loginPage = true;

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
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    void backToLogin() {
      setState(() {
        loginPage = true;
      });
    }

    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: keyboardOpen
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                loginPage == false
                    ? (customLoginTextField(nameController, Constants.NAME,
                        Icons.account_box, false))
                    : Container(),
                loginPage == false
                    ? SizedBox(
                        height: 20,
                      )
                    : Container(),
                customLoginTextField(
                    usernameController, Constants.EMAIL, Icons.mail, false),
                SizedBox(
                  height: 20,
                ),
                customLoginTextField(
                    passwordController, Constants.PASSWORD, Icons.lock, true),
                loginPage == false
                    ? SizedBox(
                        height: 20,
                      )
                    : Container(),
                loginPage == false
                    ? customLoginTextField(passwordConfirmationController,
                        Constants.PASSWORD_CONFIRMATION, Icons.lock, true)
                    : Container(),
                loginPage == false
                    ? submitOrLoginButton(Constants.SUBMIT)
                    : submitOrLoginButton(Constants.LOGIN),
                keyboardOpen == true
                    ? Container()
                    : (loginPage == true)
                        ? Container(
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  loginPage = false;
                                });
                              },
                              child: Text(Constants.REGISTER),
                            ),
                          )
                        : (keyboardOpen == false || loginPage == false)
                            ? Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        loginPage = true;
                                        usernameController.text = "";
                                        passwordController.text = "";
                                        passwordConfirmationController.text =
                                            "";
                                        nameController.text = "";
                                      });
                                    },
                                    child: Text(Constants.BACK_TO_LOGIN),
                                  ),
                                ),
                              )
                            : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding submitOrLoginButton(String type) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        color: white,
        onPressed: () {
          if (type == Constants.SUBMIT) {
            validateAndSubmit();
            setState(() {
              usernameController.text = "";
              passwordController.text = "";
              passwordConfirmationController.text = "";
              nameController.text = "";
            });
          }

          if (type == Constants.LOGIN) {
            validateAndLogin();
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Welcome()),
          );
        },
        child: type == Constants.SUBMIT
            ? Text(Constants.SUBMIT)
            : Text(Constants.LOGIN),
      ),
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
