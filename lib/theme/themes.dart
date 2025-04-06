import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../utils/app_color.dart';

class Themes {
  /// set saved theme mode based on shared pref values

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColor.primaryColor,
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.robotoTextTheme(),
    scaffoldBackgroundColor: AppColor.blackColor,
    textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColor.color9292,
        selectionColor: AppColor.colorDFDFDFTrans),
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: AppColor.whiteColor,
          fontWeight: FontWeight.w600,
          // fontFamily: strOutfitFont,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppColor.backgroundColor,
        elevation: 0),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
      hintStyle: const TextStyle(
        fontSize: 14,
        // fontFamily: strOutfitFont,
      ),
    ),
    filledButtonTheme: const FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColor.blackColor),
        foregroundColor: WidgetStatePropertyAll(AppColor.whiteColor),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColor.textColor),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColor.primaryColor),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColor.primaryColor,
      brightness: Brightness.dark,
    ),
  );
}
