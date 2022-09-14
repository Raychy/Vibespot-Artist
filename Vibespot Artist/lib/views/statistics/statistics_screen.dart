import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';

import 'album/album_screen.dart';
import 'playlist/playlist_screen.dart';
import 'release/release_screen.dart';
import 'track/track_screen.dart';

class _StatListItem {
  final String title, subtitle, routeName;

  _StatListItem(this.title, this.subtitle, this.routeName);
}

class StatisticsScreen extends StatelessWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'statistics';

  @override
  Widget get page => this;

  StatisticsScreen({Key? key}) : super(key: key);

  final items = [
    _StatListItem('My Albums', 'See all albums', AlbumScreen.routeName),
    _StatListItem('My Singles', 'See all singles', ReleaseScreen.routeName),
    _StatListItem('Playlist', 'See all playlist', PlaylistScreen.routeName),
    // _StatListItem('Album Tracks', 'See all tracks', TrackScreen.routeName),
    // _StatListItem('Release Tracks', 'See all tracks', TrackScreen.routeName),
    _StatListItem('All Tracks', 'See all tracks', TrackScreen.routeName),
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldCommon(
        appTitle: 'Analytics',
        bodyData: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            children: [
              SizedBox(height: 20),
              for (var item in items)
                _buildTile(context, item.title, item.subtitle, item.routeName)
            ],
          ),
        ));
  }

  Widget _buildTile(BuildContext context, String title, String subtitle,
          String routeName) =>
      ListTile(
        title: Text(title),
        subtitle: Text(subtitle,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
        trailing: Icon(CupertinoIcons.forward),
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
      );
}
