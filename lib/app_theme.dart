import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() => ThemeData.light().copyWith(
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 50.0,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
          bodyText1: TextStyle(
            fontSize: 18.0,
            color: Colors.black87,
            fontFamily: 'Poppins',
          ),
        ),
      );

  static ThemeData dark() => ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 50.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
          bodyText1: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
      );
}
