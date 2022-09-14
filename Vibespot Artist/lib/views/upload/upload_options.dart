import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vsartist/core/router/transissions/slide_side_route.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/views/statistics/track/select_track_screen.dart';
import 'package:vsartist/views/upload/track_upload.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';
import 'package:vsartist/views/widgets/forms.dart';

enum UploadOption { file, catalogue }

class UploadOptions extends StatefulWidget {
  final Album album;
  final bool startMode;
  final Widget? navigateTo;
  final Function()? reloadPage;
  final int count, position, total;
  const UploadOptions(
      {Key? key,
      required this.album,
      this.startMode = false,
      this.reloadPage,
      this.navigateTo,
      this.count = 1,
      this.position = 1, this.total = 1})
      : super(key: key);

  @override
  _UploadOptionsState createState() => _UploadOptionsState();
}

class _UploadOptionsState extends State<UploadOptions> {
  final FormsWidget formsWidget = FormsWidget();
  UploadOption? option;
  @override
  Widget build(BuildContext context) {
    return ScaffoldCommon(
        appTitle: 'Upload track ${widget.position} / ${widget.total}',
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: AppColors.PRIMARY,
        //     child: Icon(CupertinoIcons.add, color: Colors.white),
        //     onPressed: () => Navigator.pushNamed(
        //         context, SinglesUploadInstruction.routeName)),
        bodyData: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text('Select'),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: _button(
                            'From Catalogue', option == UploadOption.catalogue,
                            () {
                      setState(() {
                        option = UploadOption.catalogue;
                      });
                    })),
                    SizedBox(width: 40),
                    Expanded(
                        child: _button(
                            'Upload File', option == UploadOption.file, () {
                      setState(() {
                        option = UploadOption.file;
                      });
                    })),
                  ],
                ),
                Spacer(),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: formsWidget.wideButton('NEXT', context,
                        option != null ? () => _submit(context) : null)),
                SizedBox(height: 40),
              ],
            ),
          ),
        ));
  }

  Widget _button(String label, bool isSelected, Function() onPressed) =>
      Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          color: Colors.black,
          child: TextButton(
            onPressed: onPressed,
            child: SizedBox(
              // width: 110,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 16,
                      ),
                    SizedBox(width: 10),
                    Text(
                      label,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ));

  _submit(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(SlideSideRoute(
            settings: RouteSettings(name: 'album-track'),
            page: option == UploadOption.catalogue
                ? SelectTrackScreen(
                    data: widget.album,
                    position: widget.position,
                    reloadList: widget.reloadPage,
                    total: widget.total,
                    count: widget.count,
                    navigateTo: widget.navigateTo,
                  )
                // navigateTo: widget.navigateTo, )
                : TrackUpload(
                    position: widget.position,
                    count: widget.count,
                    navigateTo: widget.navigateTo,
                    album: widget.album,
                    reloadList: widget.reloadPage,
                    total: widget.total,
                  )))
        .then(
            (value) => widget.reloadPage != null ? widget.reloadPage!() : null);
  }
}
