/*
 * Copyright (c) 2021. Scarla
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
/// Classe contenant des propriétés pour l'apparence
class FlutterFlowTheme {
  static Color primaryColor = Color(0xFF25263E);
  static Color secondaryColor = Color(0xFFFF4553);
  static Color tertiaryColor = Color(0xFF252854);
  static Color appBarColor = Color(0xA2000000);
  static Color title1Color = Color(0xFF535480);
  static Color title2Color = Colors.white;
  static Color title3Color = Colors.white;
  static Color subtitle1Color = Colors.black;
  static Color subtitle2Color = Colors.white;
  static Color body1Color = Colors.white;
  static Color body2Color = Color(0xFFB2B2B2);

  static bool isUploading = false;

  String primaryFontFamily = 'Poppins';
  String secondaryFontFamily = 'Roboto';

  static TextStyle get title1 => GoogleFonts.getFont(
        'Poppins',
        color: title1Color,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      );

  static TextStyle get title2 => GoogleFonts.getFont(
        'Poppins',
        color: title2Color,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      );

  static TextStyle get title3 => GoogleFonts.getFont(
        'Poppins',
        color: title3Color,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );

  static TextStyle get subtitle1 => GoogleFonts.getFont(
        'Poppins',
        color: subtitle1Color,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );

  static TextStyle get subtitle2 => GoogleFonts.getFont(
        'Poppins',
        color: subtitle2Color,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );

  static TextStyle get bodyText1 => GoogleFonts.getFont(
        'Poppins',
        color: body1Color,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );

  static TextStyle get bodyText2 => GoogleFonts.getFont(
        'Poppins',
        color: body2Color,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override(
          {String fontFamily,
          Color color,
          double fontSize,
          FontWeight fontWeight,
          FontStyle fontStyle}) =>
      GoogleFonts.getFont(
        fontFamily,
        color: color ?? this.color,
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight ?? this.fontWeight,
        fontStyle: fontStyle ?? this.fontStyle,
      );
}
