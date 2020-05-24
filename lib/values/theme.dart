import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color blueBackgroundColor = _colorFromHex("#42b9dd");
Color greenBackgroundColor = _colorFromHex("#74c44c");
Color loginIconsColor = Colors.black54;
Color white = Colors.white;

TextStyle textStyle =
new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: white);

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}