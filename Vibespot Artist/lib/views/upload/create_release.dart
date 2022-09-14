import 'package:flutter/material.dart';
import 'package:vsartist/core/router/app_route.dart';

import 'release_form.dart';

class CreateRelease extends StatelessWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'create-release';

  @override
  Widget get page => this;
  const CreateRelease({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReleaseForm();
  }
}
