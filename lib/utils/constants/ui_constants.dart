import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kLightYellowColor = Color(0x7FFCC647);
const kYellowColor = Color(0xFFFCC546);
const kDividerColor = Color(0xffEFEFEF);
const kBorderColor = Color(0xff6F767E);

const kTextPrimary = Color(0xFF33363F);
const kgrey = Color(0xFF3A5160);
const kSilverNight = Color(0xFFB0B5B9);

Widget poppinsText(
        {required String? txt,
        required double? fontSize,
        Color color = kTextPrimary,
        FontWeight weight = FontWeight.w600,
        double? letterSpacing,
        int maxLines = 1,
        TextAlign? textAlign}) =>
    Text(
      txt!,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: weight,
            letterSpacing: letterSpacing),
      ),
    );

class AppTextStyles {
  // Poppins TextStyles
  static TextStyle normalText = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF2F3443),
  );
  static TextStyle titleText = GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF2F3443),
  );
  static TextStyle boldText = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF2F3443),
  );
  static TextStyle semiBoldText = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF2F3443),
  );
}
