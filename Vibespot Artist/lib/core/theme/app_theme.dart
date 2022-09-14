import 'package:flutter/material.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/constants/fonts.dart';

class AppTheme {
  static final inputBorder = UnderlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(4.0),
      ),
      borderSide: BorderSide.none);

//// App bar theme across app
  static const AppBarTheme appBarTheme = AppBarTheme(
    color: Colors.white,
    brightness: Brightness.dark,
    actionsIconTheme: IconThemeData(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
  );

  static const AppBarTheme appBarThemeDark = AppBarTheme(
    brightness: Brightness.light,
    color: AppColors.PRIMARY,
    actionsIconTheme: IconThemeData(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
  );

  /// dark app theme
  static final dark = _buildDarkTheme();

  /// bright app theme
  static final light = _buildLightTheme();

  static ThemeData _buildLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: Colors.white,
      // accentColor: AppColors.PRIMARY,
      canvasColor: Colors.transparent,
      iconTheme:   IconThemeData(color: Colors.black),
      primaryIconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Color(0xFF1a1a1a),
      textTheme: TextTheme(
        headline4: TextStyle(
            fontFamily: Fonts.POPPINS,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22),
        bodyText1: TextStyle(
            fontFamily: Fonts.POPPINS,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18),
        bodyText2: TextStyle(
            fontFamily: Fonts.POPPINS,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16),
        caption: TextStyle(
            fontFamily: Fonts.POPPINS,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 14),
      ),
    );
  }

  static ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      primaryColorDark: AppColors.PRIMARY,
      // fontFamily: Fonts.POPPINS,
      iconTheme: IconThemeData(color: AppColors.PRIMARY),
      primaryIconTheme: IconThemeData(color: Colors.black),
      backgroundColor: AppColors.BACKGROUND_COLOR,
      cardColor: AppColors.BACKGROUND_COLOR,
      canvasColor: AppColors.BACKGROUND_COLOR,
      textTheme: TextTheme(
        headline4: TextStyle(
            fontFamily: Fonts.POPPINS,
            fontWeight: FontWeight.bold,
            color: AppColors.PRIMARY,
            fontSize: 22),
        bodyText1: TextStyle(
            fontFamily: Fonts.POPPINS,
            fontWeight: FontWeight.bold,
            color: AppColors.PRIMARY,
            fontSize: 18),
        bodyText2: TextStyle(
            fontFamily: Fonts.POPPINS,
            fontWeight: FontWeight.bold,
            color: AppColors.PRIMARY,
            fontSize: 16),
        caption: TextStyle(
            fontFamily: Fonts.POPPINS,
            fontWeight: FontWeight.w500,
            color: AppColors.PRIMARY,
            fontSize: 14),
      ),
    );
  }

  ThemeData _buildAmoledTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      primaryColor: Colors.black,
      // accentColor: Colors.white,
      canvasColor: Colors.transparent,
      iconTheme:   IconThemeData(color: Colors.white),
      primaryIconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Color(0xFF1a1a1a),
      textTheme: TextTheme(),
    );
  }
}
