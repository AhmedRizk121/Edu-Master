import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getMaxContentWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 1100;
    if (width >= 768) return width - 64;
    return width - 32;
  }

  static EdgeInsets getPadding(BuildContext context) {
    if (isMobile(context)) return const EdgeInsets.symmetric(horizontal: 16);
    if (isTablet(context)) return const EdgeInsets.symmetric(horizontal: 32);
    return const EdgeInsets.symmetric(horizontal: 48);
  }
}