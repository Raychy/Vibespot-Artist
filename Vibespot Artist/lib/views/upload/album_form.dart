import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/services/cropper.dart';
import 'package:vsartist/views/widgets/cached_image.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';
import 'package:vsartist/views/widgets/date_input_field.dart';
import 'package:vsartist/views/widgets/dropdown_input.dart';
import 'package:vsartist/views/widgets/forms.dart';

import 'cubit/album_cubit.dart';
import 'image_upload.dart';

class AlbumForm extends StatefulWidget {
  final Album? album;
  const AlbumForm({Key? key, this.album}) : super(key: key);

  @override
  _AlbumFormState createState() => _AlbumFormState();
}

class _AlbumFormState extends State<AlbumForm> {
  FormsWidget formsWidget = FormsWidget();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late AlbumAlbum _cubit;
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _descEditingController = TextEditingController();

  File? _image;

  @override
  void initState() {
    _cubit = AlbumAlbum();
    var album = widget.album;
    if (album != null) {
      _cubit
        ..imageChanged(album.image)
        ..titleChanged(album.title)
        ..descriptionChanged(album.description)
        ..trackCountChanged(album.trackCount)
        ..releaseDateChanged(DateTime.tryParse(album.releaseDate ?? ''));
      _descEditingController.text = album.description;
      _titleEditingController.text = album.title;
    }
    super.initState();
  }

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  dispose() {
    _cubit.close();
    super.dispose();
  }

  selectGalleryImage() async {
    var imageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 24);
    _image = File(imageFile!.path);
    await _cropImage(_image?.path ?? '');
    setState(() {});
    if (_image != null) _cubit.imageChanged(_image?.path);
  }

  /// decode an image from editor
  Future<void> _cropImage(
    String path,
  ) async {
    _image = await Cropper.cropImage(path);
  }

  _submit() {
    autovalidateMode = AutovalidateMode.onUserInteraction;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      _cubit.createAlbum(context);
    }
  }

  _update() {
    autovalidateMode = AutovalidateMode.onUserInteraction;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      _cubit.updateAlbum(context, widget.album?.id?.toString() ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCommon(
      showDrawer: false,
      appTitle: 'Album ',
      bodyData: Theme(
        data: ThemeData(primarySwatch: Colors.orange),
        child: BlocBuilder<AlbumAlbum, AlbumState>(
          bloc: _cubit,
          builder: (context, state) {
            return Form(
                key: formKey,
                child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      // formsWidget.sectionHeader('Album Banner'),
                      // formsWidget.fieldSpace(),
                      // formsWidget.imageInput('Upload Cover', _image,
                      //     selectGalleryImage, widget.album?.image),
                      // if (autovalidateMode ==
                      //         AutovalidateMode.onUserInteraction &&
                      //     state.image == null)
                      //   Padding(
                      //     padding: const EdgeInsets.only(left: 20.0, top: 4),
                      //     child: Text('Please select valid cover image',
                      //         style: TextStyle(
                      //             color: Colors.red,
                      //             fontSize: 11,
                      //             fontWeight: FontWeight.w400)),
                      //   ),

                      // formsWidget.sectionHeader('Album details'),
                      formsWidget.fieldSpace(),
                      formsWidget.textFieldHeader(context, 'Album title'),
                      formsWidget.textInput('Album title', _cubit.titleChanged,
                          enabled: widget.album == null,
                          controller: _titleEditingController,
                          autovalidateMode: autovalidateMode),
                      //formsWidget.fieldSpace(),
                      SizedBox(height: 20.0),
                      formsWidget.textFieldHeader(context, 'Album description'),
                      formsWidget.textAreaInput(
                          'Album description', _cubit.descriptionChanged,
                          enabled: widget.album == null,
                          controller: _descEditingController,
                          autovalidateMode: autovalidateMode),
                      SizedBox(height: 20.0),
                      DropdownInput<int>(
                        enabled: widget.album == null,
                        key: ValueKey('release-track'),
                        label: 'Number of tracks',
                        hint: 'Number of tracks',
                        value: state.trackCount,
                        onChanged: _cubit.trackCountChanged,
                        errorText: autovalidateMode ==
                                    AutovalidateMode.onUserInteraction &&
                                state.trackCount == null
                            ? 'Please select number of tracks'
                            : null,
                        options: [
                          for (var i = 1; i < 15; i++) InputItem(i, '$i tracks')
                        ],
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        width: 600,
                        child: DateInputField(
                          enabled: widget.album == null,
                          key: ValueKey('release-date'),
                          margin: EdgeInsets.symmetric(),
                          minimumYear: DateTime.now().year,
                          firstDate: DateTime.now(),
                          maximumYear: DateTime.now().year + 100,
                          showLabel: true,
                          label: 'Proposed Release Date',
                          value: state.releaseDate,
                          onChanged: _cubit.releaseDateChanged,
                          errorText: autovalidateMode ==
                                      AutovalidateMode.onUserInteraction &&
                                  state.releaseDate == null
                              ? 'Please enter valid release date'
                              : null,
                        ),
                      ),
                      formsWidget.fieldSpace(),
                      formsWidget.textFieldHeader(context, 'Album art'),
                      ImageUpload(
                        path: state.image,
                        // cubit: _cubit,
                        view: state.image != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedImage(
                                  url: state.image ?? '',
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : null,
                        imageChanged: (path) async {
                          _cubit.imageChanged(path);
                        },
                      ),
                      SizedBox(height: 30.0),
                      if (widget.album != null)
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: formsWidget.wideButton('SAVE', context,
                                state.formValid ? _update : null,
                                isLoading: state.isLoading,
                                disable: state.isLoading))
                      else
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: formsWidget.wideButton('NEXT', context,
                                state.formValid ? _submit : null,
                                isLoading: state.isLoading,
                                disable: state.isLoading)),
                      SizedBox(height: 50.0),
                    ]));
          },
        ),
      ),
    );
  }
}
