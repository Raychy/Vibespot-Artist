import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/upload/singles-upload-instruction.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';

import 'playlist_list.dart';
import 'search/search_bar.dart';
import 'search/search_screen.dart';

class PlaylistScreen extends StatelessWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'playlist_screen';

  @override
  Widget get page => this;

  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldCommon(
        appTitle: 'Playlist',
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: AppColors.PRIMARY,
        //     child: Icon(CupertinoIcons.add, color: Colors.white),
        //     onPressed: () => Navigator.pushNamed(
        //         context, SinglesUploadInstruction.routeName)),
        bodyData: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: OpenContainer(
                closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                clipBehavior: Clip.antiAlias,
                closedColor: Colors.transparent,
                middleColor: Colors.transparent,
                closedBuilder: (c, b) => Hero(
                    tag: ValueKey('searchBar'),
                    transitionOnUserGestures: true,
                    child: SearchBar(onPressed: null)),
                openBuilder: (c, b) => SearchScreen(),
                transitionDuration: Duration(milliseconds: 700),
                transitionType: ContainerTransitionType.fade,
              ),
            ),
            Expanded(child: PlaylistList()),
          ],
        ));
  }
}
