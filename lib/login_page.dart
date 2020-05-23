import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class Login extends StatefulWidget {
  const Login({
    Key key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hideRegister = false;

  @protected
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (visible)
          setState(() {
            hideRegister = true;
          });
        else
          setState(() {
            hideRegister = false;
          });
      },
    );
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
          hideRegister == false
              ? Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: FlatButton(
                      onPressed: () {},
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
