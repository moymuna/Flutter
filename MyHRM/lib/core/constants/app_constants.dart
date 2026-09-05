import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const String appName = 'My HRM';
  static const String appVersion = '1.0.0';

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;

  static const double mobileNavWidth = 0;
  static const double tabletRailWidth = 72;
  static const double desktopDrawerWidth = 256;

  static const int defaultPageSize = 20;
  static const int maxSearchLength = 100;
}

enum ScreenSize { mobile, tablet, desktop }

ScreenSize getScreenSize(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width < AppConstants.mobileBreakpoint) return ScreenSize.mobile;
  if (width < AppConstants.tabletBreakpoint) return ScreenSize.tablet;
  return ScreenSize.desktop;
}

bool isMobile(BuildContext context) =>
    MediaQuery.sizeOf(context).width < AppConstants.mobileBreakpoint;

bool isTablet(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  return width >= AppConstants.mobileBreakpoint &&
      width < AppConstants.tabletBreakpoint;
}

bool isDesktop(BuildContext context) =>
    MediaQuery.sizeOf(context).width >= AppConstants.tabletBreakpoint;
