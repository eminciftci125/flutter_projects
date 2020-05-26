import 'package:burayabakarlar/screens/welcome.dart';
import 'package:burayabakarlar/values/constants.dart';
import 'package:burayabakarlar/values/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  TextEditingController _nameController;
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  TextEditingController _passwordConfirmationController;
  bool _result;
  int _currentPage = 0;

  @override
  initState() {
    _nameController = new TextEditingController();
    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();
    _passwordConfirmationController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Column childColumn;
    switch (_currentPage) {
      case 0:
        childColumn = _loginPage();
        break;
      case 1:
        childColumn = _registerPage();
        break;
      case 2:
        childColumn = _forgotPasswordPage();
        break;
      default:
        childColumn = new Column();
    }
    return Container(
      margin: EdgeInsets.all(40),
      child: Form(
        key: _formKey,
        child: childColumn,
      ),
    );
  }

  Column _loginPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _customLoginTextField(
            _usernameController, Constants.EMAIL, Icons.mail, false),
        SizedBox(
          height: 20,
        ),
        _customLoginTextField(
            _passwordController, Constants.PASSWORD, Icons.lock, true),
        _primaryButtons(Constants.LOGIN),
        Column(
          children: <Widget>[
            _secondaryButtons(Constants.FORGOT_MY_PASSWORD, 2),
            _secondaryButtons(Constants.REGISTER, 1),
          ],
        )
      ],
    );
  }

  Column _registerPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _customLoginTextField(
            _nameController, Constants.NAME, Icons.account_box, false),
        SizedBox(
          height: 20,
        ),
        _customLoginTextField(
            _usernameController, Constants.EMAIL, Icons.mail, false),
        SizedBox(
          height: 20,
        ),
        _customLoginTextField(
            _passwordController, Constants.PASSWORD, Icons.lock, true),
        SizedBox(
          height: 20,
        ),
        _customLoginTextField(_passwordConfirmationController,
            Constants.PASSWORD_CONFIRMATION, Icons.lock, true),
        _primaryButtons(Constants.REGISTER),
        _secondaryButtons(Constants.BACK_TO_LOGIN, 0)
      ],
    );
  }

  Column _forgotPasswordPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _customLoginTextField(
            _usernameController, Constants.EMAIL, Icons.mail, false),
        _primaryButtons(Constants.RESET_PASSWORD),
        _secondaryButtons(Constants.BACK_TO_LOGIN, 0)
      ],
    );
  }

  Padding _primaryButtons(String type) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
      child: RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          color: darkBlue,
          onPressed: () {
            if (type == Constants.LOGIN) {
              _validateAndLogin();
            }

            if (type == Constants.REGISTER) {
              _validateAndSubmit();
            }

            if (type == Constants.RESET_PASSWORD) {
              _validateAndResetPassword();
            }
          },
          child: Text(
            type,
            style: whiteTextFormStyle,
          )),
    );
  }

  TextFormField _customLoginTextField(TextEditingController _controller,
      String _hintText, IconData _iconData, bool _obscureText) {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: _obscureText,
      controller: _controller,
      autofocus: false,
      validator: (text) {
        switch (_hintText) {
          case Constants.EMAIL:
            return _validateEmail(text);
          case Constants.PASSWORD:
            return _validatePassword(text);
          case Constants.NAME:
            return _validateName(text);
          case Constants.PASSWORD_CONFIRMATION:
            return _validatePasswordConfirmation(text);
          default:
            return null;
        }
      },
      style: blueTextFormStyle,
      decoration: InputDecoration(
        hintText: _hintText,
        hintStyle: whiteTextFormStyle,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: cyan),
        ),
        icon: Icon(
          _iconData,
          color: loginIconsColor,
        ),
      ),
    );
  }

  Container _secondaryButtons(String text, int pageNumber) {
    var _padding;
    var _style;
    var _highlightColor;
    if (text == Constants.FORGOT_MY_PASSWORD) {
      _padding = const EdgeInsets.all(5);
      _style = formButtonTextStyle;
      _highlightColor = white;
    } else {
      _padding = const EdgeInsets.symmetric(vertical: 0.0);
      _style = whiteTextFormStyle;
      _highlightColor = darkBlue;
    }

    return Container(
      child: Padding(
        padding: _padding,
        child: FlatButton(
          hoverColor: Colors.white,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          splashColor: Colors.grey,
          highlightColor: _highlightColor,
          onPressed: () {
            setState(() {
              _currentPage = pageNumber;
            });
            _clearFields();
          },
          child: Text(
            text,
            style: _style,
          ),
        ),
      ),
    );
  }

  String _validateEmail(String value) {
    Pattern pattern = Constants.VALID_MAIL_PATTERN;
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return Constants.MSG_INVALID_EMAIL;
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 6 || value.length > 16) {
      return Constants.INVALID_PASSWORD;
    }
    return null;
  }

  String _validateName(String value) {
    if (value.length == 0) {
      return Constants.EMPTY_NAME;
    } else if (value.length > 20) {
      return Constants.NAME_BOUNDARY;
    }

    return null;
  }

  String _validatePasswordConfirmation(String value) {
    if (value != _passwordController.text) {
      return Constants.PASSWORD_MATCH_ERROR;
    }

    return null;
  }

  void _clearFields() {
    _formKey.currentState.reset();
    setState(() {
      _usernameController.text = "";
      _passwordController.text = "";
      _passwordConfirmationController.text = "";
      _nameController.text = "";
    });
  }

  void _validateAndResetPassword() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      if (!_formKey.currentState.validate()) {
        return;
      }

      await _auth.sendPasswordResetEmail(email: _usernameController.text);
      _clearFields();
      Fluttertoast.showToast(msg: Constants.RESET_LINK_SENT);
    } catch (e) {
      if (e.code == Constants.USER_NOT_FOUND) {
        Fluttertoast.showToast(msg: Constants.MSG_EMAIL_NOT_FOUND);
      }
    }
  }

  Future<bool> _validateAndLogin() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      if (!_formKey.currentState.validate()) {
        return false;
      }
      await _auth.signInWithEmailAndPassword(
          email: _usernameController.text, password: _passwordController.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Welcome()),
      );
      return true;
    } catch (e) {
      switch (e.code) {
        case Constants.INVALID_EMAIL:
          Fluttertoast.showToast(msg: Constants.MSG_INVALID_EMAIL);
          return false;
        case Constants.USER_NOT_FOUND:
          Fluttertoast.showToast(msg: Constants.MSG_USER_NOT_FOUND);
          return false;
        case Constants.WRONG_PASSWORD:
          Fluttertoast.showToast(msg: Constants.MSG_WRONG_PASSWORD);
          return false;
        default:
          Fluttertoast.showToast(msg: Constants.MSG_ERROR_OCCURED);
          return false;
      }
    }
  }

  Future<bool> _validateAndSubmit() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      if (!_formKey.currentState.validate()) {
        return false;
      }
      await _auth.createUserWithEmailAndPassword(
          email: _usernameController.text, password: _passwordController.text);
      _clearFields();
    } catch (e) {}
  }
}
