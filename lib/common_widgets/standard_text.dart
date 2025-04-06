import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_color.dart';

class StandardText extends StatelessWidget {
  final String label;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? align;
  final int? maxlines;
  final TextDecoration? decoration;

  // final String? fontFamilyType;
  final double? letterSpacing;

  const StandardText({
    super.key,
    required this.label,
    this.color = AppColor.textColor,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.align = TextAlign.center,
    // this.fontFamilyType = strSourceSansProRegular,
    this.maxlines,
    this.decoration = TextDecoration.none,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: align,
      maxLines: maxlines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? AppColor.textColor,
          fontSize: fontSize,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing ?? 0.2,
          height: 1.4,
          fontStyle: FontStyle.normal,
          decoration: decoration),
    );
  }
}
