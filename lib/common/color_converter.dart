import 'package:flutter/material.dart';

MaterialColor createMaterialColor(String hexCode) {
  int hexColor = int.parse(hexCode.replaceFirst('#', ''), radix: 16);

  Map<int, Color> colorSwatch = {
    50: Color(hexColor).withOpacity(0.1),
    100: Color(hexColor).withOpacity(0.2),
    200: Color(hexColor).withOpacity(0.3),
    300: Color(hexColor).withOpacity(0.4),
    400: Color(hexColor).withOpacity(0.5),
    500: Color(hexColor).withOpacity(0.6),
    600: Color(hexColor).withOpacity(0.7),
    700: Color(hexColor).withOpacity(0.8),
    800: Color(hexColor).withOpacity(0.9),
    900: Color(hexColor).withOpacity(1.0),
  };
  return MaterialColor(hexColor, colorSwatch);
}
