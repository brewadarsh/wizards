import 'package:flutter/material.dart';

class AppColor {
  const AppColor._();

  /// The default color scheme.
  static const ColorScheme hogwartsScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF2D5D65),
    onPrimary: Color(0xFFDDE6E8),
    secondary: Color(0xFF4C7084),
    onSecondary: Color(0xFFE0F7FA),
    surface: Color(0xFF121212),
    onSurface: Color(0xFFE0E0E0),
    error: Color(0xFFCF6679),
    onError: Color(0xFFFFDEE6),
  );
}
