import 'package:flutter/material.dart';

class BartrColors {
  static const Color primary = Color(0xFF122666);
  static const Color primaryLight = Color(0xFF2245B8);
  static const Color primaryFade = Color(0xFF69759F);
  static const Color deepgrey = Color(0xFF59565F);
  static const Color grey = Color(0xFF79777E);
  static const Color green = Color(0xFF0B7957);
  static const Color lightGreen = Color(0xFFF6FEFC);
  static const Color purple = Color(0xFFA9BDFF);
  static const Color lightGrey = Color(0xFFDAD8DF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color senderBubble = Color(0XFFF8F7FC);
  static const Color receiverBubble = Color(0XFFF6FEFC);
  static const Color red = Color(0xFFD8372C);
  static const Color redLight = Color(0xFFFCE9E9);
  static const Color black = Color(0xFF06020E);
  static const Color greyFill = Color(0xFFf8f8f8);
  static const Color bubbleGrey = Color(0xFFf1f0f5);
  static const MaterialColor primarysWatch = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF0D47A1),
      500: Color(_bluePrimaryValue),
      600: Color(_bluePrimaryValue),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A4),
    },
  );
  static const int _bluePrimaryValue = 0xFF2245B8;
}
