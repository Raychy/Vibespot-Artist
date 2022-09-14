import 'package:flutter/material.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/upload/album_form.dart';

class CreateAlbum extends StatelessWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'create-album';

  @override
  Widget get page => this;

  const CreateAlbum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlbumForm();
  }
}
