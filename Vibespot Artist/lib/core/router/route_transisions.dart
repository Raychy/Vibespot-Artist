import 'package:flutter/cupertino.dart';

import 'transissions/fade_route.dart';
import 'transissions/slide_side_route.dart';
import 'transissions/slide_up_route.dart';

typedef Route RouteBuilder(RouteSettings settings);
enum Transissions { fade, fade_scale, slide_right, slide_left, slide_up }

class RouteTransissions {
  static Route<dynamic> build(
      Transissions transission, RouteSettings settings, Widget page) {
    switch (transission) {
      case Transissions.slide_right:
        return SlideSideRoute(settings: settings, page: page, isRight: true);
      case Transissions.slide_left:
        return CupertinoPageRoute(
          builder: (c) => page,
          settings: settings,
        );
        // return SlideSideRoute(settings: settings, page: page, isRight: false);
      case Transissions.slide_up:
        return SlideUpRoute(settings: settings, page: page);
      default:
        return FadeRoute(settings: settings, page: page, soft: true);
    }
  }
}
