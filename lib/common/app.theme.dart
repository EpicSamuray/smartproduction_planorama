import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/common/constants.dart';

class AppTheme {
  static ThemeData get mainTheme {
    return ThemeData(
      primarySwatch: HexColors.primaryColor,
      scaffoldBackgroundColor: HexColors.primaryColor.shade900,
      inputDecorationTheme: InputDecorationTheme(
          fillColor: HexColors.primaryColor.shade900,
          filled: true,
          labelStyle: const TextStyle(
              color: Colors.white
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: HexColors.secondColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColors.tertiaryColor.shade900)
          )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: HexColors.tertiaryColor.shade900,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)
              )
          )
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(fontSize: 12.0, color: Colors.white),
      ),

    );
  }
}