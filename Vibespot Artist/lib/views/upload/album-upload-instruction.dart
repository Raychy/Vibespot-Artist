import 'package:flutter/material.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';
import 'package:vsartist/views/widgets/upload_instruction.dart';

import 'create_album.dart';

class AlbumUploadInstruction extends StatelessWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'album-upload-instruction';

  @override
  Widget get page => this;
  @override
  Widget build(BuildContext context) => ScaffoldCommon(
        appTitle: 'Album Upload Guide',
        bodyData: UploadInstruction(routeName: CreateAlbum.routeName),
        showDrawer: false,
      );
}
