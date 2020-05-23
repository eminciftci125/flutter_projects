import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';


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

  @override
  initState() {
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();

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
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.white,
              onPressed: () {},
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
                          /*     if (newuser != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Welcome()),
                      );
                      setState(() {
                      });
                    }*/
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
}

class Welcome {}
