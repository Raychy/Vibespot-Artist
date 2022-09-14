import 'package:flutter_screenutil/flutter_screenutil.dart';

extension DoubleExt on double {
  double get width => ScreenUtil().setWidth(this);
  double get height => ScreenUtil().setHeight(this);
  // double get sp => ScreenUtil().setSp(this);
}

extension IntExt on int {
  /// returns date in milliseconds as current Time + (this represented as seconds)
  int get secondsToMilliseconds =>
      DateTime.now().add(Duration(seconds: this)).millisecondsSinceEpoch;

  /// compares time in milliseconds against current timestamp
  /// and returns true if time is past
  bool get isPast => DateTime.now().millisecondsSinceEpoch > this;
  // double get height => ScreenUtil().setHeight(this);
}
