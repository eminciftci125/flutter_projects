/*
import 'package:burayabakarlar/values/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
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
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController usernameController;
  TextEditingController passwordController;
  bool keyboardOpen = false;
  bool _isLoading = false;
  Alignment childAlignment = Alignment.center;
  @override
  initState() {
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          childAlignment = visible ? Alignment.topCenter : Alignment.center;
          keyboardOpen = visible;
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  AnimatedContainer(
        curve: Curves.easeOut,
        duration: Duration(
          milliseconds: 400,
        ),
        width: double.infinity,
        height: double.infinity,
        alignment: childAlignment,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [bluebackgroundcolor, greenbackgroundcolor],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: new Container(
        padding: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image(
                image: new AssetImage('assets/images/ikon.png'),
                color: null,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: usernameController,
                autofocus: false,
                validator: (value) =>
                validateEmail(value) == null ? 'Invalid email' : null,
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
                controller: passwordController,
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
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.white,
                  onPressed: () {
                    validateAndLogin();
                  },
                  child: Text('Giriş Yap'),
                ),
              ),
              keyboardOpen == false
                  ? Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: FlatButton(
                    onPressed: () async {
                      setState(() {
                        //showProgress = true;
                      });
                      try {
                        await _auth.createUserWithEmailAndPassword(
                            email: usernameController.text,
                            password: passwordController.text);
                        */
/*     if (newuser != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Welcome()),
                      );
                      setState(() {
                       // showProgress = false;
                      });
                    }*//*

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
      ),)
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
          email: usernameController.text, password: passwordController.text);

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
*/
