import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';

import 'release_list.dart';

class ReleaseScreen extends StatelessWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'release_screen';

  @override
  Widget get page => this;

  const ReleaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldCommon(
        appTitle: 'My Singles',
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: AppColors.PRIMARY,
        //     child: Icon(CupertinoIcons.add, color: Colors.white),
        //     onPressed: () => Navigator.pushNamed(
        //         context, SinglesUploadInstruction.routeName)),
        bodyData: ReleaseList());
  }
}
