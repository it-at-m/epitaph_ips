import 'package:flutter/material.dart';

class ColorConstants {

  static Color buttonGreen = const Color.fromRGBO(141, 168, 8, 0.45);
  static Color black = Colors.black;
  static Color kvrBlue = const Color(0xff172634);
  static Color kvrBlue10 = const Color(0xffdfe2ed);
  static Color kvrBlue30 = const Color(0xffA5ABC6);
  static Color kvrBlue50 = const Color(0xff8893b3);
  static Color kvrBlue70 = const Color(0xff405685);
  static Color kvrBlue100 = const Color(0xff00245c);
  static Color white = const Color(0xffdfe1ed);
  static Color backgroundColor = const Color(0xFFB7BED3);
  static Color whiteNormal = Colors.white;
  static Color white70 = Colors.white70;
  static Color greyNormal = Colors.grey;
  static Color lightBlue = Colors.lightBlue; //frosted_button.dart
  static Color blueAccent = Colors.blueAccent;
  static Color boxShadowBlue = const Color.fromRGBO(
      31, 38, 135, 0.19); //frosted_button.dart
  static Color boxBorderWhite = Colors.white.withOpacity(0.18);
  static Color whiteWithOpacity0 = Colors.white.withOpacity(0);
  static Color boxShadowBlack = Colors.black.withOpacity(0.2);
  static Color myPositionCircle = const Color(0x00808080).withOpacity(0.3);
  static Color frostedBgColorGrey = Colors.grey.shade200.withOpacity(
      0.45);
  static Color boxBorderRed = Colors.red.shade600.withOpacity(0.45);
  static Color transparent = Colors.transparent;
}

class TextStyleConstants {

  static TextStyle buttonGreenText(context) {
    return TextStyle(color: Colors.black,
        fontSize: 0.052 * MediaQuery.of(context).size.width,
        fontWeight: FontWeight.bold);
  }

  static TextStyle headerText(context) {
    return TextStyle(color: Colors.black,
        fontSize: 0.057 * MediaQuery.of(context).size.width,
        fontWeight: FontWeight.bold);
  }

  static TextStyle headerTextNormal(context){
    return TextStyle(fontSize: 0.057 * MediaQuery.of(context).size.width);
  }

  static TextStyle normalText(context) {
    return TextStyle(color: Colors.black,
        fontSize: 0.046 * MediaQuery.of(context).size.width,
        fontWeight: FontWeight.normal);
  }

  static TextStyle normalTextBold(context) {
    return TextStyle(color: Colors.black,
        fontSize: 0.046 * MediaQuery.of(context).size.width,
        fontWeight: FontWeight.bold);
  }

  static TextStyle appBar(context) {
    return TextStyle(fontSize: 0.052 * MediaQuery.of(context).size.width,
        fontWeight: FontWeight.bold,
        color: const Color(0xffdfe1ed));
  }

  static TextStyle buttonTextBold(context){
    return TextStyle (fontSize: 0.057 * MediaQuery.of(context).size.width,
        fontWeight: FontWeight.bold);
  }

  static TextStyle buttonText(context){
    return TextStyle (fontSize: 0.057 * MediaQuery.of(context).size.width,
        fontWeight: FontWeight.normal);
  }

  static TextStyle headerTextWithColor(context) {
    return TextStyle (color: const Color(0xff172634),
      fontSize: 0.057 * MediaQuery.of(context).size.width,
      fontWeight: FontWeight.w500,);
  }

  static TextStyle hintText (context){
    return TextStyle (fontSize: 0.057 * MediaQuery.of(context).size.width,
        fontWeight: FontWeight.bold);
  }
}
