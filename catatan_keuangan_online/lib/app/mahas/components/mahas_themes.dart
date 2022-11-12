import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mahas_colors.dart';

class MahasThemes {
  static double borderRadius = 10;

  static ThemeData light = ThemeData(
    fontFamily: GoogleFonts.lato().fontFamily,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(88, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        backgroundColor: MahasColors.blue,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size(88, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: MahasColors.blue,
    ),
  );

  static BoxDecoration decoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        MahasColors.blue.withOpacity(.8),
        MahasColors.blue,
      ],
    ),
  );

  static TextStyle h1 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static InputDecoration? textFiendDecoration({
    hintText,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintText,
    );
  }

  static TextStyle title = const TextStyle(
    fontWeight: FontWeight.bold,
  );

  static TextStyle muted = TextStyle(
    color: Colors.black.withOpacity(.3),
  );
}
