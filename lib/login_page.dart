import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

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
      margin: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.text,
            controller: usernameController,
            decoration: InputDecoration(
              labelText: "Kullanıcı Adı",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30.0),
                ),
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
            decoration: InputDecoration(
              labelText: "Şifre",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
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
                       // showProgress = false;
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
}

class Welcome {}
