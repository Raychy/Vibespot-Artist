import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vsartist/models/playlist.dart';
import 'package:vsartist/services/share_service.dart';
import 'package:vsartist/views/upload/cubit/track_cubit.dart';
import 'package:vsartist/views/widgets/cached_image.dart';

class PlaylistTile extends StatelessWidget {
  final Playlist data;
  final bool placeholderMode;
  final Function() reloadPage;
  const PlaylistTile({
    Key? key,
    required this.data,
    this.placeholderMode = false,
    required this.reloadPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: placeholderMode
          ? null
          : () {
              // Navigator.of(context).push( MaterialPageRoute(builder: (context) {
              //   return  MusicList(
              //       id:data.albumId, type: 'data', title:data.title);
              // }));
            },
      leading: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Material(
            clipBehavior: Clip.antiAlias,
            shape: CircleBorder(),
            child: CachedImage(url: data.image ?? '')),
      ),
      title: placeholderMode
          ? Container(width: 300, height: 6, color: Colors.white)
          : Text(data.title, style: TextStyle(color: Colors.white)),
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
              '${data.title} ${data.genre ?? ''} ',
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
                    PopupMenuItem(
                      value: 'add',
                      child: Row(children: [
                        Icon(Icons.remove_circle),
                        SizedBox(width: 10),
                        Text('Remove from playlist')
                      ]),
                    ),
                    if (data.dynamicLinkUrl != null)
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
                    if (data.dynamicLinkUrl != null)
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
                  ]),
    );
  }

  onSelected(BuildContext context, String value) {
    switch (value) {
      case 'add':
        TrackCubit()
            .removeTrackFromPlaylist(context, data.trackId.toString())
            .then((value) => reloadPage());
        break;
      case 'share':
        if (data.dynamicLinkUrl != null)
          ShareService.text(data.dynamicLinkUrl ?? '');
        break;
      default:
    }
  }
}
