import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EveTheme {
  /// The main color of your app, e.g.; Buttons, Bars, Details, etc
  final Color primaryColor;

  /// The background color of your screens
  final Color backgroundColor;

  /// The color of the contents, e.g.: text, icons, etc
  final Color contentColor;

  final Brightness brightness;
  final SystemUiOverlayStyle overlayStyle;
  final String fontFamily = 'Quicksand';

  EveTheme._({
    required this.primaryColor,
    required this.backgroundColor,
    required this.brightness,
    required this.overlayStyle,
    required this.contentColor,
  });

  factory EveTheme.dark({
    required Color backgroundColor,
    required Color primaryColor,
    required Color contentColor,
  }) =>
      EveTheme._(
        backgroundColor: backgroundColor,
        primaryColor: primaryColor,
        contentColor: contentColor,
        brightness: Brightness.dark,
        overlayStyle: SystemUiOverlayStyle.light,
      );

  factory EveTheme.light({
    required Color backgroundColor,
    required Color primaryColor,
    required Color contentColor,
  }) =>
      EveTheme._(
        backgroundColor: backgroundColor,
        primaryColor: primaryColor,
        contentColor: contentColor,
        brightness: Brightness.light,
        overlayStyle: SystemUiOverlayStyle.dark,
      );

  ThemeData get themeData => ThemeData(
        primaryColor: primaryColor,
        brightness: brightness,
        fontFamily: fontFamily,
        splashColor: primaryColor,
        backgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(systemOverlayStyle: overlayStyle),
        textTheme: TextTheme(
          bodyText1: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: contentColor.withOpacity(0.85)),
          bodyText2: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700, color: contentColor),
          headline1: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: contentColor),
          overline: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: contentColor.withOpacity(0.85)),
        ),
      );
}
