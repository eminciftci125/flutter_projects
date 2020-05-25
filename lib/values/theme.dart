import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color blueBackgroundColor = _colorFromHex("#42b9dd");
Color greenBackgroundColor = _colorFromHex("#74c44c");
Color loginIconsColor = Colors.white;
Color white = Colors.white;
Color cyan = Colors.cyan;
Color darkBlue = Colors.blue[900];

TextStyle textStyle = new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: white);
TextStyle whiteButtonTextStyle = new TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0, color: darkBlue);
TextStyle formButtonTextStyle = new TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0, color: darkBlue);

TextStyle whiteTextFormStyle = new TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0, color: white);
TextStyle blueTextFormStyle = new TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0, color: darkBlue);

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}