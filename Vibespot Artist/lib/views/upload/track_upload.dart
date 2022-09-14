import 'package:flutter/material.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/models/release.dart';

import 'track_upload_form.dart';

class TrackUpload extends StatelessWidget {
  final Album? album;
  final Widget? navigateTo;
  final Release? release;
  final Function()? reloadList;
  final int count, position, total;
  const TrackUpload(
      {Key? key,
      this.album,
      this.release,
      this.navigateTo,
      this.reloadList, this.total = 1,
      this.count = 1,
      this.position = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TrackUploadForm(
        reloadList: reloadList,
        navigateTo: navigateTo,
        album: album,
        count: count,total: total,
        position: position,
        release: release);
  }
}
