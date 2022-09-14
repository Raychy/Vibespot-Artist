import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A simple [Cubit] which manages the [ThemeData] as its state.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void setTheme(ThemeMode mode) {
    emit(mode);
  }

  //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     systemNavigationBarColor: AppColors.NAV_BAR_COLOR,
  //     statusBarColor: Colors.black,
  //     statusBarBrightness: Brightness.dark,
  //     statusBarIconBrightness: Brightness.light,
  //     systemNavigationBarIconBrightness: Brightness.dark,
  //   ));
}
