import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.transparent,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.blue[900]),
    titleTextStyle: TextStyle(
      color: Colors.blue[900],
      fontSize: 18,
    ),
  );
}
