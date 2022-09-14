import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; 

import 'app_route.dart';
import 'route_argument.dart';
import 'route_transisions.dart';
import 'transissions/fade_route.dart';

class AppRouter with RouteAware {
  static final GlobalKey<NavigatorState> navigationKey = GlobalKey();
  final List<AppRoute> _routes;
  final AppRoute? defaultRoute;

  AppRouter(this._routes, [this.defaultRoute]);

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return _buildRoutes(settings);
  }

  Route<dynamic> _buildRoutes(RouteSettings settings) {
    if (kDebugMode) print('building route ${settings.name}');
    AppRoute route = _routes.firstWhere((i) => i.routeNam == settings.name,
        orElse: () => defaultRoute ?? _routes[0]);
    if (settings.arguments is RouteArgument)
      return (settings.arguments as RouteArgument).routeBuilder(
         route.page,
         settings,
      );
       if (settings.arguments is Transissions)
      return RouteTransissions.build(
          settings.arguments as Transissions, settings, route.page);
    return FadeRoute(
      page: route.page,
      settings: settings,
    );
  }
}
