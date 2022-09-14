import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/constants/api_urls.dart';
import 'package:vsartist/constants/dimens.dart';
import 'package:vsartist/models/release.dart';
import 'package:vsartist/views/widgets/cached_image.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';
import 'package:vsartist/views/widgets/date_input_field.dart';
import 'package:vsartist/views/widgets/forms.dart';

import 'cubit/album_cubit.dart';
import 'image_upload.dart';

class ReleaseForm extends StatefulWidget {
  final Release? release;
  const ReleaseForm({Key? key, this.release}) : super(key: key);

  @override
  _ReleaseFormState createState() => _ReleaseFormState();
}

class _ReleaseFormState extends State<ReleaseForm> {
  FormsWidget formsWidget = FormsWidget();
  final scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late AlbumAlbum _cubit;
  final TextEditingController _controller = TextEditingController();

  String releaseNameTooltip =
      'This is used to identify the upload of tracks and it is not seen by your listener';

  var uploadDate = DateTime.now();
  @override
  void initState() {
    _cubit = AlbumAlbum();
    if (widget.release != null) {
      _controller.text = widget.release?.releaseName ?? '';
      _cubit
        ..titleChanged(widget.release?.releaseName)
        ..imageChanged(widget.release?.imageUrl)
        ..releaseDateChanged(
            DateTime.tryParse(widget.release?.releaseDate ?? ''));
    }
    super.initState();
  }

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  dispose() {
    _cubit.close();
    super.dispose();
  }

  _submit() {
    autovalidateMode = AutovalidateMode.onUserInteraction;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _cubit.createRelease(context);
    }
  }

  _update() {
    autovalidateMode = AutovalidateMode.onUserInteraction;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      _cubit.updateRelease(context, '${widget.release!.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCommon(
      // scaffoldState: scaffoldState,
      appTitle: widget.release != null ? 'Update Release' : 'Create Release',
      bodyData: Theme(
        data: ThemeData(primarySwatch: Colors.orange),
        child: BlocBuilder<AlbumAlbum, AlbumState>(
            bloc: _cubit,
            builder: (context, state) => Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.PADDING_SMALL),
                  child: ListView(
                      children: <Widget>[
                        SizedBox(height: 30.0),
                        // formsWidget.sectionHeader('Release details'),
                        // SizedBox(height: 15.0),
                        SizedBox(height: 20.0),
                        formsWidget.textFieldHeader(
                            context, 'Release Name'),
                        SizedBox(height: 4.0),
                        formsWidget.textInput(
                            'Release Name', _cubit.titleChanged,
                            enabled: widget.release == null,
                            controller: _controller,
                            autovalidateMode: autovalidateMode),
                        // SizedBox(height: 20.0),
                        // DropdownInput<int>(
                        //   key: ValueKey('release-track'),
                        //   label: 'Number of tracks',
                        //   hint: 'Number of tracks',
                        //   value: state.trackCount,
                        //   onChanged: _cubit.trackCountChanged,
                        //   errorText: autovalidateMode ==
                        //               AutovalidateMode
                        //                   .onUserInteraction &&
                        //           state.trackCount == null
                        //       ? 'Please select number of tracks'
                        //       : null,
                        //   options: [
                        //     for (var i = 1; i < 15; i++)
                        //       InputItem(i, '$i tracks')
                        //   ],
                        // ),
                        SizedBox(height: 20.0),
                        SizedBox(
                          // width: 600,
                          child: DateInputField(
                            enabled: widget.release == null,
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
                                        AutovalidateMode
                                            .onUserInteraction &&
                                    state.releaseDate == null
                                ? 'Please enter valid release date'
                                : null,
                          ),
                        ),
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

                        SizedBox(height: 15.0),
                        if (widget.release != null)
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: formsWidget.wideButton(
                                  'UPDATE', context, _update))
                        else
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: formsWidget.wideButton(
                                  'NEXT', context, _submit)),
                        SizedBox(height: 50.0),
                      ]),
                ))),
      ),
      showDrawer: false,
    );
  }
}
