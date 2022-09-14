import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vsartist/core/router/transissions/slide_side_route.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/core/extensions/index.dart';
import 'package:vsartist/services/share_service.dart';
import 'package:vsartist/views/statistics/track/album_track_screen.dart';
import 'package:vsartist/views/upload/album_form.dart';
import 'package:vsartist/views/upload/cubit/track_cubit.dart';
import 'package:vsartist/views/widgets/cached_image.dart';

import 'bloc/album_bloc.dart';

class AlbumTile extends StatelessWidget {
  final Album album;
  final bool placeholderMode;
  final Function()? reloadPage;
  const AlbumTile(
      {Key? key,
      required this.album,
      this.placeholderMode = false,
      this.reloadPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.tryParse(album.releaseDate ?? '');
    return ListTile(
      // onTap: placeholderMode
      //     ? null
      //     : () {
      //         Navigator.of(context)
      //             .push(SlideSideRoute(
      //                 settings: RouteSettings(),
      //                 page: AlbumTrackScreen(
      //                   data: album,
      //                 )))
      //             .then((value) => reloadPage != null ? reloadPage!() : null);
      //       },
      leading: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Material(
            clipBehavior: Clip.antiAlias,
            shape: CircleBorder(),
            child: CachedImage(url: album.image ?? '')),
      ),
      title: placeholderMode
          ? Container(width: 300, height: 6, color: Colors.white)
          : Text(album.title, style: TextStyle(color: Colors.white)),
      subtitle: placeholderMode
          ? Row(
              children: [
                SizedBox(
                    width: 200,
                    child:
                        Container(width: 100, height: 4, color: Colors.white)),
              ],
            )
          : Text(
              date?.readableFormat ?? '',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 11.0),
            ),
      trailing: placeholderMode
          ? SizedBox(
              width: 20,
              height: 20,
              child: Material(shape: CircleBorder(), color: Colors.white))
          : PopupMenuButton(
              onSelected: (String v) => onSelected(context, v),
              itemBuilder: (c) => [
                    if (album.dynamicLinkUrl != null)
                      PopupMenuItem(
                        value: 'share',
                        child: Row(
                          children: [
                            Icon(Icons.share),
                            SizedBox(width: 10),
                            Text('Share'),
                          ],
                        ),
                      ),
                    PopupMenuItem(
                      value: 'tracks',
                      child: Row(
                        children: [
                          Icon(Icons.music_note),
                          SizedBox(width: 10),
                          Text('Tracks'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 10),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete),
                          SizedBox(width: 10),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ]),
    );
  }

  onSelected(BuildContext context, String value) {
    switch (value) {
      case 'delete':
        TrackCubit()
            .delete(context, albumID: album.id.toString())
            .then((value) => BlocProvider.of<AlbumBloc>(context).load());
        break;
      case 'share':
        if (album.dynamicLinkUrl != null)
          ShareService.text(album.dynamicLinkUrl ?? '');
        break;
      case 'edit':
        Navigator.of(context)
            .push(SlideSideRoute(
                settings: RouteSettings(name: ''),
                page: AlbumForm(album: album)))
            .then((value) => context.read<AlbumBloc>().load());
        break;
      case 'tracks':
        Navigator.of(context)
            .push(SlideSideRoute(
                settings: RouteSettings(),
                page: AlbumTrackScreen(
                  data: album,
                )))
            .then((value) => reloadPage != null ? reloadPage!() : null);
        break;
      default:
    }
  }
}
