import 'package:burayabakarlar/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/splash.dart';
import 'values/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: email == null ? HomePage() : Welcome(),
  ));
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage(
        'assets/images/ikon.png'); //<- Creates an object that fetches an image.
    var image = new Image(image: assetsImage);
    return new SplashScreen(
        seconds: 1,
        navigateAfterSeconds: null,
        title: new Text('WeDidIt', style: textStyle),
        image: image,
        gradientBackground: new LinearGradient(
            colors: [blueBackgroundColor, greenBackgroundColor],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: MediaQuery.of(context).size.height / 6,
        onClick: () => print("Flutter Egypt"),
        loaderColor: white);
  }
}
