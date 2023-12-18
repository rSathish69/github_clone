import 'package:flutter/material.dart';
import 'package:github_clone/configuration/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        fontSize: 8,
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    fontFamily: GoogleFonts.inter().fontFamily,
    scaffoldBackgroundColor: AppColors.scffoldBackgroundColor,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    useMaterial3: true,
    //fontFamily: GoogleFonts.notoSans.toString(),
    colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor, onPrimary: AppColors.white),
    listTileTheme: ListTileThemeData(
      textColor: AppColors.black,
      style: ListTileStyle.list,
    ),
    dividerTheme: DividerThemeData(color: AppColors.grey50),
    dialogTheme: const DialogTheme(surfaceTintColor: AppColors.white),
    cardColor: AppColors.white,
  );
}
