
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisRoute extends PageRouteBuilder {
  final Widget page;
  final RouteSettings settings;
  final bool horizontal;
  final Duration? duration;
  SharedAxisRoute(
      {this.horizontal = true, this.duration, required this.settings,required this.page})
      : super(
            settings: settings,
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              //         print(animation.value);
              // print(secondaryAnimation.value);
              // animation =
              //     CurvedAnimation(parent: animation, curve: Curves.decelerate);
              return SharedAxisTransition(
                  transitionType: horizontal
                      ? SharedAxisTransitionType.horizontal
                      : SharedAxisTransitionType.vertical,
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  child: child);
            });
}