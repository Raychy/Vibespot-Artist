import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/upload/album-upload-instruction.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';

import 'album_list.dart';

class AlbumScreen extends StatelessWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'album_screen';

  @override
  Widget get page => this;

  const AlbumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldCommon(
        appTitle: 'Album',
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: AppColors.PRIMARY,
        //     child: Icon(CupertinoIcons.add, color: Colors.white),
        //     onPressed: () =>
        //         Navigator.pushNamed(context, AlbumUploadInstruction.routeName)),
        bodyData: AlbumList());
  }
}
