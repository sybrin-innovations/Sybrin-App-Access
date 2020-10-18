import 'package:access/themes/sybrin_colors.dart';
import 'package:flutter/material.dart';

class SybrinTheme {
  static String _fontFamily = 'Roboto';

  static final ThemeData aiTheme = ThemeData(
    backgroundColor: SybrinColors.daaark,
    primaryColor: SybrinColors.sky,
    accentColor: SybrinColors.tea,
    cardColor: SybrinColors.grey.withOpacity(0.5),
    disabledColor: SybrinColors.grey.withOpacity(0.5),
    cursorColor: SybrinColors.black,
    errorColor: SybrinColors.hotPink,
    textTheme: TextTheme(
      //Info Screen titles
      headline4: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 48,
        fontWeight: FontWeight.w900,
        color: SybrinColors.white,
      ),
      //Info screen subtitles
      headline5: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 25,
        fontWeight: FontWeight.w500,
        color: SybrinColors.white,
      ),
      //Titles
      headline1: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 25,
        fontWeight: FontWeight.w900,
      ),
      //Larger titles
      headline2: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w900,
      ),
      //Body size bold text
      headline3: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w900,
      ),
      //Subtitles
      subtitle1: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 400,
          letterSpacing: 0.42,
          fontWeight: FontWeight.w500,
          color: SybrinColors.white),
      //Paragraph Text black
      bodyText1: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: SybrinColors.black),
      //Paragraph Text white
      bodyText2: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: SybrinColors.white),
      //Button Text
      button: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 19.8,
          fontWeight: FontWeight.w900,
          color: SybrinColors.white),
    ),
  );
}
