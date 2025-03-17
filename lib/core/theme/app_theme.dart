import 'package:flutter/material.dart';

const _portalGreen = Color(0xFF00FFAA);
const _cosmicBlack = Color(0xFF1A1A2E);
const _nebulaBlue = Color(0xFF16213E);
const _mortyYellow = Color(0xFFFFD700);
const _labWhite = Color(0xFFE0E0E0);

ThemeData lightTheme() {
  return ThemeData.light().copyWith(
    primaryColor: _portalGreen,
    scaffoldBackgroundColor: Colors.grey.shade100,
    appBarTheme: const AppBarTheme(color: Colors.white, elevation: 4),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: _portalGreen,
      unselectedItemColor: _nebulaBlue,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: _portalGreen,
    scaffoldBackgroundColor: _cosmicBlack,
    appBarTheme: const AppBarTheme(color: _nebulaBlue, elevation: 4),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _nebulaBlue,
      selectedItemColor: _mortyYellow,
      unselectedItemColor: _labWhite,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
    ),
  );
}
