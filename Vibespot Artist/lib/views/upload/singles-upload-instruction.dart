import 'package:flutter/material.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';
import 'package:vsartist/views/widgets/upload_instruction.dart';

import 'create_release.dart';

class SinglesUploadInstruction extends StatelessWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'singles-upload-instruction';

  @override
  Widget get page => this;
  @override
  Widget build(BuildContext context) {
    return ScaffoldCommon(
      appTitle: 'Song Upload Guide',
      bodyData: UploadInstruction(routeName: CreateRelease.routeName),
      showDrawer: false,
    );
  }
}
