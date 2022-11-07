import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mahas_colors.dart';

class MahasThemes {
  static ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size(88, 40),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    backgroundColor: MahasColors.blue,
  );

  static ThemeData light = ThemeData(
    fontFamily: GoogleFonts.lato().fontFamily,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: raisedButtonStyle,
    ),
  );

  static BoxDecoration decoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        MahasColors.lightBlue.withOpacity(.6),
        MahasColors.lightBlue,
      ],
    ),
  );

  static TextStyle h1 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}
