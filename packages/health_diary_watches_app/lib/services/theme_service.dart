import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ThemeService {
  static const scheme = FlexScheme.deepBlue;

  ThemeData get lightTheme => FlexThemeData.light(
        scheme: scheme,
        // Use very subtly themed app bar elevation in light mode.
        appBarElevation: 0.5,
      );

  ThemeData get dartTheme => FlexThemeData.dark(
        scheme: scheme,
        // Use stronger themed app bar elevation in dark mode.
        appBarElevation: 2,
      );

  const ThemeService();
}
