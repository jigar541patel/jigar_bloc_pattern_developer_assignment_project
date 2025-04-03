import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:jigar_developer_flutter_assigments/utils/secure_storage.dart';

import '../utils/app_color.dart';
import '../utils/strings.dart';

class Themes {

  ThemeNotifier() {
    setSavedThemeMode();
  }


  /// set saved theme mode based on shared pref values
  Future<void> setSavedThemeMode() async {
    await SecureStorage.getData(spThemeMode).then((value) {
      if (value == ThemeType.light.value) {
        _themeMode = ThemeMode.light;
      } else if (value == ThemeType.dark.value) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = getSystemDefaultTheme();
      }
      notifyListeners();
    });
  }

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColor.primaryColor,
      brightness: Brightness.light,
    ),
    //textTheme: GoogleFonts.outfitTextTheme(),
    // textTheme: ThemeData(fontFamily: strOutfitFont).textTheme,
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
        side: BorderSide(color: AppColor.primaryColor),
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
