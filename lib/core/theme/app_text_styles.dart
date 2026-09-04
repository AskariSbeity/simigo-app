import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get heading => GoogleFonts.inter(
    fontSize: 27,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get subheading => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get label => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get body => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle get button => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle get link => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.orange,
  );
}