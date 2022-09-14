import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';

import 'track_list.dart';

class TrackScreen extends StatelessWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'track_screen';

  @override
  Widget get page => this;

  const TrackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldCommon(
        appTitle: 'My Track',
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: AppColors.PRIMARY,
        //     child: Icon(CupertinoIcons.add, color: Colors.white),
        //     onPressed: () => Navigator.pushNamed(
        //         context, SinglesUploadInstruction.routeName)),
        bodyData: TrackList());
  }
}
