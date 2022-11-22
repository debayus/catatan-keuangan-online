import 'package:flutter/material.dart';

class MahasColors {
  static const Color brown = Color(0xFFA66E68);
  static const Color cream = Color(0xFFF2C094);
  static const Color blue = Color(0xFF03658C);
  static const Color yellow = Color(0xFFffc145);
  static const Color red = Color(0xFFff4000);
  static const Color grey = Color(0xFFb8b8d1);

  static const List<Color> grafikColors = [
    brown,
    yellow,
    blue,
    cream,
    red,
    grey,
  ];

  static const Color primary = brown;
  static const Color light = Colors.white;
  static const Color dark = Colors.black;
  static const Color danger = red;
  static const Color warning = yellow;

  static BoxDecoration decoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        MahasColors.cream.withOpacity(.8),
        MahasColors.cream,
      ],
    ),
  );
}
