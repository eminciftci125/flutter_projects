import 'package:burayabakarlar/theme.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

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
    var assetsImage = new AssetImage(
        'assets/images/ikon.png'); //<- Creates an object that fetches an image.
    var image = new Image(image: assetsImage, fit: BoxFit.cover);
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
        photoSize: 100.0,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Günlük Paket Sayısı",
                style: textStyle,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                ),
              ),
              Text(
                "Paketteki sigara sayısı",
                style: textStyle,
              ),
              Text(
                "Bir paketin ücreti",
                style: textStyle,
              ),
            ],
          ),
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
