import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:vsartist/views/artist_features/artist_global/functions.dart';
import 'package:vsartist/views/artist_features/artist_global/networks.dart';
import 'package:vsartist/views/artist_features/uploads/upload-bloc.dart';
import 'package:vsartist/views/artist_features/uploads/upload-common.dart';
import 'package:vsartist/views/artist_features/uploads/uploads-model.dart';
import 'package:vsartist/views/common/uidata.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';
import 'package:vsartist/views/widgets/forms.dart';

class AlbumUpload extends StatefulWidget {
  final int? pages;
  final int? page;
  final String? releaseName;
  final UploadAlbum? uploadAlbum;
  final List<int>? single_Ids;

  AlbumUpload(
      {this.pages,
      this.page,
      this.releaseName,
      this.uploadAlbum,
      this.single_Ids}) {
    print("Single Ids");
    print(this.single_Ids);
  }

  @override
  _AlbumUploadState createState() => _AlbumUploadState();
}

class _AlbumUploadState extends State<AlbumUpload>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  FormsWidget formsWidget = FormsWidget();
  Functions functions = Functions();
  UploadCommon uploadCommon = UploadCommon();
  final scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  // final GlobalKey<FormState> formKey2 = new GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _featureByController = TextEditingController();
  final TextEditingController _producedByController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  Music musicUpload = new Music();
  UploadAlbum? uploadAlbum;
  NetworkRequest network = NetworkRequest();
  String? _filePath;
  List<int> single_Ids = [];
  List<MusicModel> musicsModel = [];
  MusicModel? musicModel;

  String value = "";
  int? _initialSelectedType = 1;
  int? selectedId;
  String? title, description, featureBy, producedBy, genre;

  void getSongs() async {
    List<dynamic> allSongs = await (network.getSIngleTracksOnly(
        context: context) as FutureOr<List<dynamic>>);
    setState(() {
      musicsModel = allSongs as List<MusicModel>;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    functions.checkInternet(scaffoldState);
    getSongs();
    uploadAlbum = widget.uploadAlbum;
  }

  onSavedTrackDescription(value) => setState(() {
        musicUpload.description = value;
        description = musicUpload.description;
      });

  onSavedFeatureArtists(value) => setState(() {
        musicUpload.featureBy = value;
        featureBy = musicUpload.featureBy;
      });

  onSavedProducedBy(value) => setState(() {
        musicUpload.producedBy = value;
        producedBy = musicUpload.producedBy;
      });

  onChangeGenre(value) => setState(() {
        musicUpload.genre = value;
        genre = musicUpload.genre;
      });

  void _getFilePath() async {
    try {
      var file = await FilePicker.platform.pickFiles(type: FileType.audio);
      if ((file?.files.length ?? 0) < 1) return;
      String? filePath = file!.paths[0];
      if (filePath == '') {
        return;
      }
      setState(() {
        this._filePath = filePath;
        musicUpload.song = filePath;
      });
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  submitfromUploadButton(index, count) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<bool>(
            stream: uploadBloc.showProgress,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data!) {
                return new Center(child: CircularProgressIndicator());
                // return Padding(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 8.0, vertical: 20),
                //     child: (index < count)
                //         ? formsWidget.wideButton('NEXT', context, _submit)
                //         : formsWidget.wideButton('UPLOAD', context, _submit));
              } else {
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20),
                    child: (index < count)
                        ? formsWidget.wideButton(
                            'NEXT', context, _submitfromUpload)
                        : formsWidget.wideButton(
                            'UPLOAD', context, _submitfromUpload));
              }
            }),
      );

  _submitfromUpload() async {
    if (_initialSelectedType == 0 && widget.page! + 1 <= widget.pages!) {
      // print(widget.page + 1);
      if (selectedId == null && musicUpload.genre == null) {
        functions.showSnack('Track cannot be empty', scaffoldState);
        return;
      }
      if (widget.page != null && selectedId != null) {
        if (widget.page! + 1 < widget.pages! || widget.single_Ids != null) {
          widget.single_Ids!.add(int.parse(musicModel!.id!));
          uploadAlbum!.tracks![widget.page!].single_Ids = widget.single_Ids;
          uploadAlbum!.single_Ids =
              uploadAlbum!.tracks![widget.page!].single_Ids;
          if (widget.page! + 1 < widget.pages!) {
            uploadCommon.albumTrackPage(context, widget.pages, widget.page! + 1,
                uploadAlbum!.title, uploadAlbum, widget.single_Ids);
          }
        }
      }
    }

    if (_initialSelectedType == 1 && widget.page! + 1 <= widget.pages!) {
      // print(widget.page + 1);
      title = _titleController.text;
      description = _descriptionController.text;
      featureBy = _featureByController.text;
      producedBy = _producedByController.text;
      if (title!.length < 1 ||
          description!.length < 1 ||
          featureBy!.length < 1 ||
          producedBy!.length < 1 ||
          musicUpload.genre == null) {
        functions.showSnack('field(s) cannot be empty', scaffoldState);
        return;
      }

      musicUpload.title = title;
      musicUpload.description = description;
      musicUpload.featureBy = featureBy;
      musicUpload.producedBy = producedBy;
      musicUpload.genre = musicUpload.genre;
      uploadAlbum!.tracks![widget.page!] = musicUpload;

      if (widget.page! + 1 < widget.pages!) {
        uploadCommon.albumTrackPage(context, widget.pages, widget.page! + 1,
            uploadAlbum!.title, uploadAlbum, widget.single_Ids);
      }
    }
    if (widget.page! + 1 == widget.pages) {
      // print(widget.page + 1);
      convertImage(uploadAlbum!.image);
      uploadAlbum!.tracks![widget.page!].single_Ids = widget.single_Ids;
      uploadAlbum!.single_Ids = uploadAlbum!.tracks![widget.page!].single_Ids;
      print(uploadAlbum!.single_Ids);

      uploadBloc.uploadAlbum(uploadAlbum!, context);
      uploadBloc.snacksBar.listen((data) async {
        if (data != null) {
          functions.showSnack(data, scaffoldState);
          formsWidget.delayTime(3);
        }
      });
    } else {
      functions.showSnack('field(s) cannot be empty', scaffoldState);
      return;
    }
  }

  void convertImage(image) {
    if (image == null || image.contains(';')) return;

    image = File(image);
    String base64Image = base64Encode(image.readAsBytesSync());
    String extension = path.extension(image.path);
    extension.replaceAll('.', '');
    setState(() {
      uploadAlbum!.image = '$extension;$base64Image';
    });
  }

  body() => SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // SizedBox(height: 20),
          formsWidget.sectionHeader('Select Track to upload'),
          Padding(
            padding: EdgeInsets.all(1),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Text(
                  '',
                  // style: new TextStyle(
                  //   color: Colors.orange.shade700,
                  //   fontFamily: 'Poppins-Bold',
                  //   fontSize: 20.0,
                  // ),
                ),
              ),
              subtitle: DropdownButtonFormField<int>(
                isExpanded: true,
                isDense: true,
                iconEnabledColor: Colors.red,
                value: _initialSelectedType,
                onChanged: (int? value) {
                  setState(() {
                    _initialSelectedType = value;
                    print(_initialSelectedType);
                  });
                },
                decoration: InputDecoration(
                  fillColor: Color(0xFF040404),
                  filled: true,
                  hintText: "Select Track to upload",
                  hintStyle: new TextStyle(
                    color: Colors.orange.shade700,
                    fontFamily: 'Poppins-Bold',
                    fontSize: 13.0,
                  ),
                ),
                validator: (int? value) {
                  if (value == null) {
                    return "Select a track";
                  }
                  return null;
                },
                items: [
                  DropdownMenuItem<int>(
                    child: Text(
                      'Select from Previously uploaded single tracks',
                      style: new TextStyle(
                        color: Colors.orange.shade700,
                        fontFamily: 'Poppins-Bold',
                        fontSize: 13.0,
                      ),
                    ),
                    value: 0,
                  ),
                  DropdownMenuItem<int>(
                    child: Text(
                      'Select from File Manager',
                      style: new TextStyle(
                        color: Colors.orange.shade700,
                        fontFamily: 'Poppins-Bold',
                        fontSize: 14.0,
                      ),
                    ),
                    value: 1,
                  )
                ],
              ),
            ),
          ),
          // _initialSelectedType == 0
          //     ? Padding(padding: EdgeInsets.all(24), child: form2())
          //     : Padding(padding: EdgeInsets.all(24), child: forms()),

          Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Form(
                  key: formKey,
                  child: new Column(
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _initialSelectedType == 0
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 1),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 24.0, horizontal: 1.0),
                                          child: new FormField(
                                            builder: (FormFieldState state) {
                                              return InputDecorator(
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.transparent,
                                                  hintText: 'Select Track',
                                                  hintStyle: new TextStyle(
                                                      color: Colors.white),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 0,
                                                          horizontal: 3),
                                                  enabledBorder: inputBorder(),
                                                  errorBorder: inputBorder(),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            22),
                                                  ),
                                                ),
                                                child: Theme(
                                                  data: ThemeData.dark(),
                                                  child:
                                                      DropdownButtonFormField<
                                                          MusicModel>(
                                                    isExpanded: true,
                                                    isDense: true,
                                                    iconEnabledColor:
                                                        Colors.amber,
                                                    elevation: 120,
                                                    hint: DropdownMenuItem(
                                                      child: Text(
                                                        "Select from Single track",
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.amber),
                                                      ),
                                                    ),
                                                    items:
                                                        _buildArtistsDropDownItems(
                                                            musicsModel),
                                                    value: musicModel,
                                                    onChanged:
                                                        (MusicModel? value) {
                                                      setState(() {
                                                        musicModel = value;
                                                        selectedId = int.parse(
                                                            value!.id!);
                                                        print(musicModel!.id);
                                                      });
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 1),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        formsWidget
                                            .sectionHeader('Track Release'),
                                        formsWidget.fieldSpace(),

                                        formsWidget.formField(_titleController,
                                            'Track Title', TextInputType.text),

                                        formsWidget.formAreaField(
                                            _descriptionController,
                                            'Track Description',
                                            TextInputType.text,
                                            lines: 3),

                                        //formsWidget.fieldSpace(),
                                        formsWidget.dropdownField(
                                            'Genre',
                                            functions.genres(),
                                            musicUpload.genre,
                                            onChangeGenre,
                                            label: 'Genre'),

                                        formsWidget
                                            .sectionHeader('Featuring By'),
                                        formsWidget.fieldSpace(),

                                        formsWidget.formField(
                                            _featureByController,
                                            'Enter Feature Artists.',
                                            TextInputType.text),

                                        formsWidget
                                            .sectionHeader('Produced By'),
                                        formsWidget.fieldSpace(),

                                        formsWidget.formField(
                                            _producedByController,
                                            'Produced by.',
                                            TextInputType.text),

                                        formsWidget.sectionHeader('Track file'),
                                        formsWidget.fieldSpace(),
                                        formsWidget.uploadFile(
                                            musicUpload.song, _getFilePath),
                                        formsWidget.fieldSpace(),
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      ),
                      functions.progressIndicator(networkBloc.sendProgress),
                      submitfromUploadButton(widget.page! + 1, widget.pages),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Padding(padding: EdgeInsets.all(1), child: forms())
        ],
      ));

  List<DropdownMenuItem<MusicModel>> _buildArtistsDropDownItems(
      List<MusicModel> artsts) {
    return artsts.map((MusicModel musicModel) {
      return DropdownMenuItem<MusicModel>(
        child: Text(
          musicModel.title! +
              "\t" +
              musicModel.description! +
              "\t" +
              musicModel.description!,
          style: TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.amber),
        ),
        value: musicModel,
      );
    }).toList();
  }

  inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.elliptical(0, 0)),
      borderSide: const BorderSide(color: Colors.white, width: 0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        leading:
        IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  UiData.dashboard, (Route<dynamic> route) => false);
            });
        return false;
      },
      child: ScaffoldCommon(
        // scaffoldState: scaffoldState,
        appTitle:
            '#${widget.page! + 1}/${widget.pages} - ${widget.releaseName}',
        bodyData: body(),
        showDrawer: false,
      ),
    );
  }
}
