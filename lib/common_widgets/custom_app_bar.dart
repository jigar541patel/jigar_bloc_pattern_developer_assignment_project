import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18, // Matches the Figma size
            fontWeight: FontWeight.w500, // Medium weight (500)
            color: Colors.white, // White text
            fontFamily: GoogleFonts.roboto().fontFamily),
      ),
      leading: SizedBox(),
      backgroundColor: const Color(0xFF2196F3),
      // Adjust color to match your Figma
      centerTitle: false,
      // Left align title as per UI
      elevation: 0, // No shadow, as seen in the Figma
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
