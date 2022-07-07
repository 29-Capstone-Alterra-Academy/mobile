import 'package:flutter/material.dart';

class NomizoTheme {
  static ThemeData nomizoTheme = ThemeData(
    /// COLOR THEME
    brightness: Brightness.light,
    primarySwatch: nomizoTosca,
    scaffoldBackgroundColor: nomizoDark.shade50,

    /// TEXT|FONT THEME
    fontFamily: 'Inter',
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: nomizoDark.shade900,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: nomizoDark.shade900,
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: nomizoDark.shade900,
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: nomizoDark.shade900,
      ),
      bodySmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: nomizoDark.shade900,
      ),
    ),

    /// BUTTON THEME
    // textbutton theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: nomizoTosca.shade600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    // outlinebutton theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: nomizoTosca.shade600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    // elevatedbutton theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: nomizoTosca.shade600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    /// Appbar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 1,
      backgroundColor: nomizoDark.shade50,
      shadowColor: nomizoDark.shade100,
      iconTheme: IconThemeData(
        color: nomizoDark.shade900,
      ),
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: nomizoDark.shade900,
        fontWeight: FontWeight.w600,
      ),
    ),

    tabBarTheme: TabBarTheme(
      labelColor: nomizoDark.shade900,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelColor: nomizoDark.shade500,
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static MaterialColor nomizoTosca = const MaterialColor(
    0XFF016273,
    <int, Color>{
      50: Color(0XFFAADBE3),
      100: Color(0XFF80C9D5),
      200: Color(0XFF56B7C8),
      300: Color(0XFF2BA5BA),
      400: Color(0XFF0193AC),
      500: Color(0XFF017B8F),
      600: Color(0XFF016273),
      700: Color(0XFF014A56),
      800: Color(0XFF003139),
      900: Color(0XFF001D22),
    },
  );

  static MaterialColor nomizoRed = const MaterialColor(
    0XFFFE2C55,
    <int, Color>{
      50: Color(0XFFFFD5DD),
      100: Color(0XFFFFB9C6),
      200: Color(0XFFFE95AA),
      300: Color(0XFFFE728E),
      400: Color(0XFFFE4F71),
      500: Color(0XFFFE2C55),
      600: Color(0XFFDD183E),
      700: Color(0XFFA91D39),
      800: Color(0XFF7F162B),
      900: Color(0XFF550F1C),
    },
  );

  static MaterialColor nomizoDark = const MaterialColor(
    0XFF9B9B9B,
    <int, Color>{
      50: Color(0XFFFEFEFE),
      100: Color(0XFFE8E8E8),
      200: Color(0XFFDCDCDC),
      300: Color(0XFFC5C5C5),
      400: Color(0XFFBABABA),
      500: Color(0XFF9B9B9B),
      600: Color(0XFF7C7C7C),
      700: Color(0XFF5D5D5D),
      800: Color(0XFF3E3E3E),
      900: Color(0XFF010101),
    },
  );
}
