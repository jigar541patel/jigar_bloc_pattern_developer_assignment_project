import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String leadingIcon;
  final String? tailIcon;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.leadingIcon,
    this.controller,
    this.tailIcon,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: SvgPicture.asset(
          fit: BoxFit.scaleDown,
          leadingIcon,
          height: 25,
          width: 25,
        ),
        suffixIcon:
        tailIcon!=null?
        SvgPicture.asset(
          fit: BoxFit.scaleDown,
          tailIcon!,
          height: 25,
          width: 25,
        ):SizedBox(),
        // Icon from UI
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400, // Medium weight
          fontFamily: GoogleFonts.roboto().fontFamily,
          color: AppColor.color949C9E, // Light gray hint color
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),

          borderSide: const BorderSide(
              color: AppColor.boxBorderColor, width: 1), // Light border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              const BorderSide(color: AppColor.boxBorderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
              color: AppColor.primaryColor, width: 1), // Blue border on focus
        ),

      ),
    );
  }
}
