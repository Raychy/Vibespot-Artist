import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vsartist/core/router/transissions/slide_side_route.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/models/release.dart';
import 'package:vsartist/core/extensions/index.dart';
import 'package:vsartist/services/share_service.dart';
import 'package:vsartist/views/upload/cubit/track_cubit.dart';
import 'package:vsartist/views/upload/release_form.dart';
import 'package:vsartist/views/upload/track_upload.dart';
import 'package:vsartist/views/widgets/cached_image.dart';

import 'bloc/release_bloc.dart';

class ReleaseTile extends StatelessWidget {
  final Release release;
  final bool placeholderMode;
  final Album? album;
  final int? count, position, total;
  final Function()? reloadList;
  // reloadList: _reload(),
  final bool select;
  const ReleaseTile(
      {Key? key,
      required this.release,
      this.placeholderMode = false,
      this.album,
      this.count,
      this.position,
      this.select = false,
      this.reloadList, this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.tryParse(release.releaseDate ?? '');
    return ListTile(
      onTap: placeholderMode
          ? null
          : () {
              if (select) {
                if ((release.tracks?.length ?? 0) > 0)
                  TrackCubit()
                      .releaseToAlbum(context, release.tracks![0].id.toString(),
                          album?.id?.toString() ?? '',
                          count: count ?? 1, position: position ?? 1,total: total ?? 1)
                      .then(
                          (value) => reloadList != null ? reloadList!() : null);
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please add a track to this release'),
                    ),
                  );
                }
                // .then((value) => reloadList != null ? reloadList!() : null);

              } else {
                // Navigator.of(context).push(SlideSideRoute(
                //     settings: RouteSettings(),
                //     page: ReleaseForm(release: release)));
              }
            },
      leading: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Material(
            clipBehavior: Clip.antiAlias,
            shape: CircleBorder(),
            child: CachedImage(
                url: release.imageUrl ?? release.track?.songImage ?? '')),
      ),
      title: placeholderMode
          ? Container(width: 300, height: 6, color: Colors.white)
          : Text(release.releaseName, style: TextStyle(color: Colors.white)),
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
          : select
              ? Text(
                  'Select'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontSize: 9),
                )
              : PopupMenuButton(
                  onSelected: (String v) => onSelected(context, v),
                  itemBuilder: (c) => [
                        if ((release.tracks?.length ?? 0) < 1)
                          PopupMenuItem(
                            value: 'upload',
                            child: Row(
                              children: [
                                Icon(Icons.file_upload),
                                SizedBox(width: 10),
                                Text('Upload Track'),
                              ],
                            ),
                          ),
                        if (release.tracks != null &&
                            release.tracks!.isNotEmpty &&
                            release.tracks![0].dynamicLinkUrl != null)
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
            .delete(context, releaseID: release.id.toString())
            .then((value) => BlocProvider.of<ReleaseBloc>(context).load());
        break;
      case 'edit':
        Navigator.of(context)
            .push(SlideSideRoute(
                settings: RouteSettings(name: ''),
                page: ReleaseForm(release: release)))
            .then((value) => context.read<ReleaseBloc>().load());
        break;
      case 'share':
        if (release.tracks != null &&
            release.tracks!.isNotEmpty &&
            release.tracks![0].dynamicLinkUrl != null) {
          ShareService.text(release.tracks![0].dynamicLinkUrl ?? '');
        }
        break;
      case 'upload':
        Navigator.push(
            context,
            SlideSideRoute(
                settings: RouteSettings(name: ''),
                page: TrackUpload(
                  release: release,
                  reloadList: () {},
                ))).then((value) => context.read<ReleaseBloc>().load());
        break;
      default:
    }
  }
}
