import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData nutroboTheme() {
  return ThemeData(
    useMaterial3: true,

    // Define the default brightness and colors.
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.black,
      brightness: Brightness.light,
    ),

    buttonTheme: ButtonThemeData(
        buttonColor: Colors.black,
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.dark,
        )
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey.shade800),
        iconColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16))
      )
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey.shade500,
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.black,
    ),

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 28,
      ),
      titleMedium: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 22,
      ),
      titleSmall: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 16,
      ),
      displayLarge: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 24,
      ),
      displayMedium: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 18,
      ),
      displaySmall: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 12,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 20,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 16,
      ),
      bodySmall: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 12,
      ),
      labelLarge: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 20,
      ),
      labelSmall: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 16,
      ),
      labelMedium: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 12,
      ),
    ),
  );
}

// TextStyle? displayLarge,
//     TextStyle? displayMedium,
// TextStyle? displaySmall,
// this.headlineLarge,
// TextStyle? headlineMedium,
//     TextStyle? headlineSmall,
// TextStyle? titleLarge,
//     TextStyle? titleMedium,
// TextStyle? titleSmall,
//     TextStyle? bodyLarge,
// TextStyle? bodyMedium,
//     TextStyle? bodySmall,
// TextStyle? labelLarge,
// this.labelMedium,
// TextStyle? labelSmall,