import 'package:flutter/material.dart';

ThemeData light({Color color = const Color(0xFF039D55)}) => ThemeData(
      fontFamily: 'Roboto',
      primaryColor: color,
      //primarySwatch: Colors.green,
      secondaryHeaderColor: const Color(0xFF1ED7AA),
      disabledColor: const Color(0xFFBABFC4),
      backgroundColor: const Color(0xFFF3F3F3),
      errorColor: const Color(0xFFE84D4F),
      brightness: Brightness.light,
      hintColor: const Color(0xFF9F9F9F),
      cardColor: Colors.white,
      colorScheme: ColorScheme.light(primary: color, secondary: color),
      // radioTheme:
      //     RadioThemeData(overlayColor: MaterialStateProperty.resolveWith<Color>(
      //   (states) {
      //     if (states.contains(MaterialState.disabled)) {
      //       return Colors.grey;
      //     }
      //     return color;
      //   },
      // ), fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      //   if (states.contains(MaterialState.disabled)) {
      //     return Colors.grey;
      //   }
      //   return color;
      // })),
      textButtonTheme:
          TextButtonThemeData(style: TextButton.styleFrom(primary: color)),
    );
