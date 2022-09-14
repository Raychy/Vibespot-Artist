import 'package:extended_image/extended_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/core/router/app_router.dart';
import 'package:vsartist/services/upload/upload_service.dart';
import 'package:vsartist/services/cropper.dart';
import 'package:vsartist/views/upload/cubit/track_cubit.dart';
import 'package:vsartist/views/widgets/app_dialog.dart';

class ImageUpload extends StatefulWidget {
  final TrackCubit? cubit;
  final Widget? view;
  final String? path;
  final bool displayOnlyView;
  final Future Function(String)? upload, imageChanged;
  const ImageUpload(
      {Key? key,
      this.cubit,
      this.path,
      this.upload,
      this.view,
      this.imageChanged, this.displayOnlyView = false})
      : super(key: key);

  @override
  _AudioUploadState createState() => _AudioUploadState();
}

class _AudioUploadState extends State<ImageUpload> {
  File? _file;

  uploadFile() async {
    AppDialog.showLoadingDialog(
        context,
        Card(
            margin: EdgeInsets.all(20),
            color: AppColors.BACKGROUND_COLOR,
            child: SizedBox.fromSize(
                size: Size(600, 60),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        SizedBox.fromSize(
                            // size: Size.fromRadius(30),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Theme(
                                  data: ThemeData.dark(),
                                  child: CupertinoActivityIndicator(
                                      // strokeWidth: 1,
                                      ),
                                ))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Uploading image',
                              style: TextStyle(color: Colors.white)),
                        ),
                        // LinearProgressIndicator(),
                      ],
                    )))));

    if (widget.upload != null) {
      await widget.upload!(_file?.path ?? '');
    } else {
      var url =
          await GetIt.I<UploadService>().upload(_file?.path ?? '', 'song_art');
      await Future.delayed(Duration(milliseconds: 1000));
      AppRouter.navigationKey.currentState?.pop();

      if (url != null) {
        widget.cubit?.imageChanged(url);

        if (widget.imageChanged != null) {
          widget.imageChanged!(url);
        }
      } else {
        AppDialog.show(
            context, 'Error', 'An error occurred, could not upload image');
      }
    }
  }

  // pickFile() async {
  //   var result = await ImagePicker.platform.pickImage(
  //     allowMultiple: false,
  //     type: FileType.image,
  //     // allowedExtensions: ['.mp3', '.wav']
  //   );

  //   if (result != null && result.files.single.path != null) {
  //     _file = File(result.files.single.path ?? '');
  //     if (_file != null) uploadFile();
  //   }
  // }

  Future _getImage() async {
    ImageSource? mode;

    await showCupertinoModalPopup(
        context: context,
        builder: (c) {
          return CupertinoActionSheet(
              message: Text('Select option for picking file'),
              cancelButton: CupertinoActionSheetAction(
                onPressed: () => Navigator.of(c).pop(),
                child: Text('Cancel',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400)),
              ),
              actions: <Widget>[
                CupertinoActionSheetAction(
                  onPressed: () {
                    mode = ImageSource.camera;
                    Navigator.of(c).pop();
                  },
                  child: Text('Camera',
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400)),
                ),
                CupertinoActionSheetAction(
                    onPressed: () {
                      mode = ImageSource.gallery;
                      Navigator.of(c).pop();
                    },
                    child: Text('Gallery',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400))),
              ]);
        });
    if (mode != null) {
      var image = await ImagePicker().pickImage(
        source: mode!,
        maxHeight: 1024,
      );
      //  _file = File(result.files.single.path ?? '');
      // if (_file != null) uploadFile();
      //     AppDialog.showLoadingDialog(context);
      // AppRouter.navigationKey.currentState?.pop();
      if (image != null) _cropImage(image.path);
    }
  }

  /// decode an image from editor
  Future<void> _cropImage(
    String path,
  ) async {
    var file = await Cropper.cropImage(path);

    _file = file;

    if (_file != null) uploadFile();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _getImage,
      child:widget.displayOnlyView && widget.view != null? widget.view: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            // color: AppColors.PRIMARY.withOpacity(.03),
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: Colors.white, width: .3)),
        child:  Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.image,
                  color: Colors.orange.shade700,
                ),
                SizedBox(width: 20),
                Text('Selected image',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300)),
                Spacer(),
                if (widget.cubit?.state.image != null || widget.path != null)
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
              ],
            ),
            if (widget.view != null) widget.view!
          ],
        ),
      ),
    );
  }
}
