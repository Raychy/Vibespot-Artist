import 'package:flutter/material.dart';

extension B on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get primaryColor => Theme.of(this).primaryColor;
}
