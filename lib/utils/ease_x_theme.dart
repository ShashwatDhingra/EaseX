import 'package:flutter/material.dart';

class EaseXTheme {
  // Light Theme
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF6200EE), // Primary Purple
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Light Grey
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6200EE),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF212121)), // Dark Text
          bodyMedium: TextStyle(color: Color(0xFF424242)), // Medium Dark Text
        ),
        cardColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF6200EE)),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF6200EE),
          textTheme: ButtonTextTheme.primary,
        ),
      );

  // Dark Theme
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFBB86FC), // Light Purple
        scaffoldBackgroundColor: const Color(0xFF121212), // Dark Grey
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1B24), // Dark AppBar
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Light Text
          bodyMedium: TextStyle(color: Color(0xFFB0BEC5)), // Greyish Text
        ),
        cardColor: const Color(0xFF1E1E1E),
        iconTheme: const IconThemeData(color: Color(0xFFBB86FC)),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFFBB86FC),
          textTheme: ButtonTextTheme.primary,
        ),
      );
}
