import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vsartist/constants/strings.dart';
import 'package:vsartist/core/router/app_router.dart';
import 'package:vsartist/core/router/routes.dart';
import 'package:vsartist/core/theme/app_theme.dart';
import 'package:vsartist/views/splash_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GestureDetector(
        onTap: () {
          WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
        },
        child: ScreenUtilInit(
            designSize: Size(375, 667),
            // allowFontScaling: false,
            builder: () => MaterialApp(
                  title: Strings.APP_TITLE,
                  theme: AppTheme.dark,
                  darkTheme: AppTheme.dark,
                  debugShowCheckedModeBanner: false,
                  home: SplashPage(),
                  navigatorKey: AppRouter.navigationKey,
                  onGenerateRoute: AppRouter(Routes.all).onGenerateRoute,
                )));
  }
}
