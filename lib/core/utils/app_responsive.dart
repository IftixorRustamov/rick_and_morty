import 'package:flutter/material.dart';

double appH(double height) => AppResponsive.height(height);

double appW(double width) => AppResponsive.width(width);

abstract class AppResponsive {
  static late double screenHeight;
  static late double screenWidth;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
  }

  static double height(double number) => (number / 932) * screenHeight;

  static double width(double number) => (number / 430) * screenWidth;
}
