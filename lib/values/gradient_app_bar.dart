import 'package:flutter/material.dart';
import 'package:burayabakarlar/values/theme.dart';

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GradientAppBar("Custom Gradient App Bar"),
        Container()
      ],
    );
  }
}

class GradientAppBar extends StatelessWidget {
  final String _title;
  final double _barHeight = 50.0;

  GradientAppBar(this._title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + _barHeight,
      child: Center(
        child: Text(
          _title,
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [blueBackgroundColor, greenBackgroundColor],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.8, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
