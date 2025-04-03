import 'package:flutter/material.dart';
import 'strings.dart';

class AppColor {
  //// Add A App All Statics Colors.
  static const Color primaryColor = Color(0xFF1DA1F2);
  static const Color primaryDarkColor = Color(0xFF1BACE3);

  static const Color primaryTransparentColor = Color(0x2f023b78);
  static const Color backgroundColor = Color(0xFF0F1A24);
  static const Color color21384A = Color(0xFF21384A);
  static const Color backgroundCardColor = Color(0xFF17212B);
  static const Color textFieldBackgroundColor = Color(0xFF1E293B);
  static const Color currencyConverterCardColor = Color(0xFFD8B1FF);
  static const Color color07111A = Color(0xFF07111A);
  static const Color color8FB0CC = Color(0xFF8FB0CC);
  static const Color colorFF7E4D = Color(0xFFFF7E4D);
  static const Color colorF27608 = Color(0xFFF27608);
  static const Color color000D19 = Color(0xFF000D19);
  static const Color colorIslamicBackgroundColor = Color(0xFF0087FF);
  static const Color offerBackgroundColor = Color(0xFFFF36D0);
  static const Color salaamHaajiCardColor = Color(0xFF063561);

  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color bgBlackColor = Color(0xFF070E16);
  static const Color bgColor = Color(0xFFE5E5E5);
  static const Color familyFinderCardColor = Color(0xFF002648);
  static const Color color08FF08 = Color(0xFF08FF08);
  static const Color color6A6A6A = Color(0xFF6A6A6A);
  static const Color colorF0F0F0 = Color(0xFFF0F0F0);
  static const Color color304F69 = Color(0xFF304F69);

  // static const Color textHeadingColor = Color(0xFF4D4D4D);
  static const Color textHeadingColor = Color(0xFFEEEDF8);
  static const Color textHeadingLightColor = Color(0xB3FFFFFF);

  // static const Color textColor = Color(0xFF2B2B2B);
  static const Color textColor = Color(0xFFEEEDF8);

  // static const Color backgroundColor = Color(0xFFEEEDF8);
  static const Color whiteLightColor = Color(0xFFFBFBFB);

  static const Color greenColor = Color(0xff0d9500);
  static const Color yellowColor = Color(0xffffd823);
  static const Color colorDFDFDFTrans = Color(0xA3D5D5D5);
  static const Color color4D4D = Color(0xFF4D4D4D);
  static const Color color9292 = Color(0xFF929292);
  static const Color colorA3A3A3 = Color(0xFFA3A3A3);

  static const Color colorErrorFF3257 = Color(0xFFFF3257);
  static const Color colorCommonCardBG = Color.fromRGBO(224, 225, 238, 1);
}

class AppTextStyle {
  static const TextStyle inputHintText = TextStyle(
      color: AppColor.color9292,
      fontSize: 17,
      fontFamily: strSourceSansProRegular);
  static const TextStyle inputText = TextStyle(
      color: AppColor.whiteColor,
      fontSize: 17,
      fontFamily: strSourceSansProRegular);
}

class AppButtonStyle {
  static ButtonStyle iconButtonStyle(Color bgColor) {
    return IconButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: bgColor,
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    );
  }
}
