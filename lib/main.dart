import 'file:///C:/Users/Duygu/AndroidStudioProjects/flutter_projects/flutter_projects/lib/values/theme.dart';
import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/splash.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new HomePage(),
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
    var assetsImage = new AssetImage('assets/images/ikon.png'); //<- Creates an object that fetches an image.
    var image = new Image(image: assetsImage);
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new AfterSplash(),
        title: new Text('WeDidIt', style: textStyle),
        image: image,
        gradientBackground: new LinearGradient(
            colors: [bluebackgroundcolor, greenbackgroundcolor],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: MediaQuery.of(context).size.height/6,
        onClick: () => print("Flutter Egypt"),
        loaderColor: white);
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Login(),
        ),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [bluebackgroundcolor, greenbackgroundcolor],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
      ),
    );
  }
}
