import 'package:flutter/material.dart';

ThemeData admin = ThemeData(
  hintColor: Color(0xff333333),
  primaryColor: Color(0xff00A859),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Color(0xffe3e3e3),
  ),
  scaffoldBackgroundColor: Color(0xff333333),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff333333),
    iconTheme: IconThemeData(color: Color(0xffe3e3e3)),
    elevation: 0,
    centerTitle: true,
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Color(0xff333333))
      .copyWith(error: Color(0xffa3000b)),
);
