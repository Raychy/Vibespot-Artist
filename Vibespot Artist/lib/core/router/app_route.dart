import 'package:flutter/material.dart';

abstract class AppRoute {
  /// route name for particular route
  static String get routeName => '';

  String get routeNam;

  /// instance  of this page
  Widget get page;
}
