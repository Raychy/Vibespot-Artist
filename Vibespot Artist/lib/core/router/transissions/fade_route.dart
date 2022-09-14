import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  final RouteSettings settings;
  final bool soft;
  final Duration? duration;
  FadeRoute({this.soft = false, this.duration,required this.settings,required this.page})
      : super(
            settings: settings,
            transitionDuration: duration ?? Duration(milliseconds: 300),
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              // animation =
              //     CurvedAnimation(parent: animation, curve: Curves.decelerate);
              return soft
                  ? FadeTransition(
                      opacity: animation,
                      child: FadeTransition(
                          opacity: ReverseAnimation(secondaryAnimation),
                          // animation: animation,
                          // secondaryAnimation: secondaryAnimation,
                          child: child))
                  : FadeThroughTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      child: child);
            });
}
