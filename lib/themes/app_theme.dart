import "package:flutter/material.dart";

class AppTheme {
  static const Color primaryDarkBlue = Color(0xFF0C123F);
  static const Color accentYellow = Color(0xFFFFC527);
  static const Color textCream = Color(0xFFF8F0CC);

  //tema oscuro
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: accentYellow),
    ),
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: textCream,
      displayColor: textCream,
    ),
    colorScheme: const ColorScheme.dark(
      primary: accentYellow,
      secondary: accentYellow,
    ),
    iconTheme: const IconThemeData(color: accentYellow),
  );

  //tema claro
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: primaryDarkBlue),
    ),
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: primaryDarkBlue,
      displayColor: primaryDarkBlue,
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryDarkBlue,
      secondary: primaryDarkBlue,
    ),
    iconTheme: const IconThemeData(color: primaryDarkBlue),
  );
}
