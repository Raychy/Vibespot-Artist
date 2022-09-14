import 'package:flutter/material.dart';

enum TransisionType { slide_up, slide_right, slide_left, slide_down }

/// this file holds several custom page transissions to be used for animating between Routes



class DynamicSlideRoute extends PageRouteBuilder {
  final Widget page;
  final RouteSettings settings;
  final Duration? duration;
  final Duration? exitDuration;
  final TransisionType? entrance1;
  final TransisionType? exit1;
  final TransisionType? entrance2;
  final TransisionType? exit2;

  DynamicSlideRoute({
    this.exitDuration,
    this.entrance1 = TransisionType.slide_left,
    this.exit1 = TransisionType.slide_right,
    this.entrance2 = TransisionType.slide_left,
    this.exit2 = TransisionType.slide_right,
    this.duration,
   required this.settings,
   required this.page,
  }) : super(
          settings: settings,
          reverseTransitionDuration:
              exitDuration ?? Duration(milliseconds: 400),
          transitionDuration: duration ?? Duration(milliseconds: 400),
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              page,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            // print(animation.value);
            // print(secondaryAnimation.value);
            return mapTransitionToTransission(
                animation: animation,
                multiplier: 1,
                type: secondaryAnimation.isDismissed ? entrance1 : entrance2,
                child: mapTransitionToTransission(
                    multiplier: .6,
                    animation: ReverseAnimation(secondaryAnimation),
                    type: secondaryAnimation.isDismissed ? exit1 : exit2,
                    child: child));
          },
        );
}

SlideTransition mapTransitionToTransission(
    {TransisionType? type,
   required Animation<double> animation,
    required Widget child,
    double multiplier = 1}) {
  switch (type) {
    case TransisionType.slide_right:
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(-1 * multiplier, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    case TransisionType.slide_left:
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1 * multiplier, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    case TransisionType.slide_up:
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -1 * multiplier),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    case TransisionType.slide_down:
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 1 * multiplier),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );

    default:
      return SlideTransition(
          position: Tween<Offset>(
        begin: Offset(-1 * multiplier, 0),
        end: Offset.zero,
      ).animate(ReverseAnimation(animation)));
  }
}

