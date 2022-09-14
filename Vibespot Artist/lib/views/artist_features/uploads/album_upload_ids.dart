// import 'dart:convert';
// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path/path.dart' as path;
// import 'package:vsartist/views/global/functions.dart';
// import 'package:vsartist/views/global/networks.dart';
// import 'package:vsartist/views/uploads/upload-bloc.dart';
// import 'package:vsartist/views/uploads/upload-common.dart';
// import 'package:vsartist/views/uploads/uploads-model.dart';
// import 'package:vsartist/views/widgets/common-scaffold.dart';
// import 'package:vsartist/views/widgets/forms.dart';
//
// class AlbumSelectedIdsUpload extends StatefulWidget {
//   final int pages;
//   final int page;
//   final String releaseName;
//   final UploadAlbum uploadAlbum;
//   final List<int> songs;
//   AlbumSelectedIdsUpload(
//       {this.pages, this.page, this.releaseName, this.uploadAlbum, this.songs});
//   @override
//   _AlbumSelectedIdsUploadState createState() => _AlbumSelectedIdsUploadState();
// }
//
// class _AlbumSelectedIdsUploadState extends State<AlbumSelectedIdsUpload>
//     with SingleTickerProviderStateMixin {
//   AnimationController controller;
//   Animation<double> animation;
//
//   FormsWidget formsWidget = FormsWidget();
//   Functions functions = Functions();
//   UploadCommon uploadCommon = UploadCommon();
//   final scaffoldState = GlobalKey<ScaffoldState>();
//   final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
//   Music musicUpload = new Music();
//   UploadAlbum uploadAlbum;
//   NetworkRequest network = NetworkRequest();
//   String _filePath;
//
//   //  String _time;
//   List<MusicModel> musicsModel = List();
//   ////////////////
//   String value = "";
//   List<DropdownMenuItem<String>> menuitems = List();
//   bool disabledropdown = true;
//   List<MultiSelectDialogItem<int>> multiItem = List();
//   List<String> sendtoServer = List();
//
//   void multiSelectItem(int index, bool shouldRemove) {}
//   var notExe = [];
//   void populateMultiselect() {
//     notExe = [];
//     for (int i = 0; i < musicsModel.length; i++) {
//       final sExe = musicsModel[i];
//       multiItem.add(MultiSelectDialogItem(i, sExe.title, sExe.id));
// //      if (sExe.checked) {
// //        notExe.add(i);
// //      }
//     }
//   }
//   ////////
//
//   void onSelectMethod(dynamic index, bool isSelected, String identity) {
//     var isSendtoServer = sendtoServer.contains(identity);
//     if (isSelected) {
//       if (!isSendtoServer) {
//         sendtoServer.add(identity);
//       }
//     } else {
//       if (isSendtoServer) {
//         sendtoServer.remove(identity);
//       }
//     }
//     print(sendtoServer);
//   }
//
//   void _showMultiSelect(BuildContext context) async {
//     multiItem = [];
//     populateMultiselect();
//     final items = multiItem;
//
//     final selectedValues = await showDialog<Set<dynamic>>(
//       context: context,
//       builder: (BuildContext context) {
//         return MultiSelectDialog(
//           items: items,
//           initialSelectedValues: notExe.toSet(),
//           onSelect: onSelectMethod,
//         );
//       },
//     );
//   }
//
//   void getSongs() async {
//     List<MusicModel> allSongs = await network.getAllMusics(context: context);
//     setState(() {
//       musicsModel = allSongs;
//     });
//   }
//
//   /////////
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     functions.checkInternet(scaffoldState);
//     getSongs();
//     uploadAlbum = widget.uploadAlbum;
//   }
//
//   onSavedTrackTitle(value) => setState(() {
//         musicUpload.title = value;
//       });
//   onSavedTrackDescription(value) => setState(() {
//         musicUpload.description = value;
//       });
//
//   onSavedFeatureArtists(value) => setState(() {
//         musicUpload.featureBy = value;
//       });
//
//   onSavedProducedBy(value) => setState(() {
//         musicUpload.producedBy = value;
//       });
//
//   onChangeGenre(value) => setState(() {
//         musicUpload.genre = value;
//       });
//
//   void _getFilePath() async {
//     try {
//       String filePath = await FilePicker.getFilePath(type: FileType.AUDIO);
//       if (filePath == '') {
//         return;
//       }
//       setState(() {
//         this._filePath = filePath;
//         musicUpload.song = filePath;
//       });
//     } on PlatformException catch (e) {
//       print("Error while picking the file: " + e.toString());
//     }
//   }
//
//   submitButton(index, count) => Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: StreamBuilder<bool>(
//             stream: uploadBloc.showProgress,
//             initialData: false,
//             builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//               if (snapshot.data) {
//                 return new Center(child: CircularProgressIndicator());
//                 // return Padding(
//                 //     padding: const EdgeInsets.symmetric(
//                 //         horizontal: 8.0, vertical: 20),
//                 //     child: (index < count)
//                 //         ? formsWidget.wideButton('NEXT', context, _submit)
//                 //         : formsWidget.wideButton('UPLOAD', context, _submit));
//               } else {
//                 return Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 8.0, vertical: 20),
//                     child: (index < count)
//                         ? formsWidget.wideButton('NEXT', context, _submit)
//                         : formsWidget.wideButton('UPLOAD', context, _submit));
//               }
//             }),
//       );
//
//   _submit() async {
//     print(sendtoServer);
// //    if (formKey.currentState.validate()) {
// //      formKey.currentState.save();
// //
// //      if (musicUpload.genre == null) {
// //        functions.showSnack('Genre cannot be empty', scaffoldState);
// //        return;
// //      }
// //
// //      if (musicUpload.song == null) {
// //        functions.showSnack('Track file cannot be empty', scaffoldState);
// //        return;
// //      }
// //
// //      uploadAlbum.tracks[widget.page] = musicUpload;
// //      if (widget.page + 1 < widget.pages) {
// //        uploadCommon.albumTrackUploadPage(context, widget.pages,
// //            widget.page + 1, uploadAlbum.title, uploadAlbum);
// //      } else {
// //        convertImage(uploadAlbum.image);
// //
// //        uploadBloc.uploadAlbum(uploadAlbum, context);
// //
// //        uploadBloc.snacksBar.listen((data) async {
// //          if (data != null) {
// //            functions.showSnack(data, scaffoldState);
// //            formsWidget.delayTime(3);
// //          }
// //        });
// //      }
// //    }
//   }
//
//   void convertImage(image) {
//     if (image == null || image.contains(';')) return;
//
//     image = File(image);
//     String base64Image = base64Encode(image.readAsBytesSync());
//     String extension = path.extension(image.path);
//     extension.replaceAll('.', '');
//     setState(() {
//       uploadAlbum.image = '$extension;$base64Image';
//     });
//   }
//
//   forms() => Container(
//         child: new Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             new Form(
//               key: formKey,
//               child: new Column(
//                 children: <Widget>[
//                   new Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         new Padding(
//                           padding: const EdgeInsets.only(top: 1),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               formsWidget.sectionHeader('Track Release'),
//                               formsWidget.fieldSpace(),
//                               formsWidget.textInput(
//                                   'Track Title', onSavedTrackTitle),
//                               //formsWidget.fieldSpace(),
//                               formsWidget.textAreaInput(
//                                   'Track Description', onSavedTrackDescription,
//                                   lines: 3),
//                               //formsWidget.fieldSpace(),
//                               formsWidget.dropdownField(
//                                   'Genre',
//                                   functions.genres(),
//                                   musicUpload.genre,
//                                   onChangeGenre,
//                                   label: 'Genre'),
//
//                               formsWidget.sectionHeader('Featuring By'),
//                               formsWidget.fieldSpace(),
//                               formsWidget.textInput('Enter Feature Artists.',
//                                   onSavedFeatureArtists),
//
//                               formsWidget.sectionHeader('Produced By'),
//                               formsWidget.fieldSpace(),
//                               formsWidget.textInput(
//                                   'Produced by.', onSavedProducedBy),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   RaisedButton(
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(5.0)),
//                                     elevation: 2.0,
//                                     onPressed: () {
//                                       _showMultiSelect(context);
//                                       setState(() {});
//                                     },
//                                     color: Colors.white,
//                                   ),
//                                   formsWidget.sectionHeader(
//                                       'Upload from \nFile manager'),
//                                 ],
//                               ),
//
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   formsWidget.uploadFile(
//                                       musicUpload.song, _getFilePath),
//                                   formsWidget.uploadFile(
//                                       musicUpload.song, _getFilePath),
//                                 ],
//                               ),
//
//                               formsWidget.sectionHeader('Track file'),
//                               formsWidget.fieldSpace(),
//                               formsWidget.uploadFile(
//                                   musicUpload.song, _getFilePath),
//                               formsWidget.fieldSpace(),
//                               functions
//                                   .progressIndicator(networkBloc.sendProgress),
//                               submitButton(widget.page + 1, widget.pages),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//
//   body() => SingleChildScrollView(
//           child: Column(
//         mainAxisSize: MainAxisSize.max,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           SizedBox(height: 20),
//           Padding(padding: EdgeInsets.all(15), child: forms())
//         ],
//       ));
//
//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldCommon(
//       scaffoldState: scaffoldState,
//       appTitle: '#${widget.page + 1}/${widget.pages} - ${widget.releaseName}',
//       bodyData: body(),
//       showDrawer: false,
//     );
//   }
// }
//
// // ================== coped from stakeoverflow
//
// class MultiSelectDialogItem<V> {
//   const MultiSelectDialogItem(this.value, this.label, this.identity);
//
//   final V value;
//   final String identity;
//   final String label;
// //  final Function(int index, bool shouldInclude) onSelect;
// }
//
// class MultiSelectDialog<V> extends StatefulWidget {
//   MultiSelectDialog(
//       {Key key, this.items, this.initialSelectedValues, this.onSelect})
//       : super(key: key);
//
//   final List<MultiSelectDialogItem<V>> items;
//   final Set<V> initialSelectedValues;
//   final Function(V index, bool shouldInclude, String identity) onSelect;
//
//   @override
//   State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
// }
//
// class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
//   final _selectedValues = Set<V>();
//
//   void initState() {
//     super.initState();
//     if (widget.initialSelectedValues != null) {
//       _selectedValues.addAll(widget.initialSelectedValues);
//     }
//   }
//
//   void _onItemCheckedChange(V itemValue, bool checked, String identity) {
//     setState(() {
//       if (checked) {
//         _selectedValues.add(itemValue);
//         widget.onSelect(itemValue, true, identity);
//         print(_selectedValues.add(itemValue));
//       } else {
//         _selectedValues.remove(itemValue);
//         widget.onSelect(itemValue, false, identity);
//       }
//     });
//   }
//
//   void _onCancelTap() {
// //    Navigator.pop(context);
//     Navigator.pop(context);
//   }
//
//   void _onSubmitTap() {
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Select songs to upload'),
//       contentPadding: EdgeInsets.only(top: 12.0),
//       content: SingleChildScrollView(
//         child: ListTileTheme(
//           contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
//           child: ListBody(
//             children: widget.items.map(_buildItem).toList(),
//           ),
//         ),
//       ),
//       actions: <Widget>[
//         FlatButton(
//           child: Text('CANCEL'),
//           onPressed: _onCancelTap,
//         ),
//         FlatButton(
//           child: Text('OK'),
//           onPressed: _onSubmitTap,
//         )
//       ],
//     );
//   }
//
//   Widget _buildItem(MultiSelectDialogItem<V> item) {
//     final checked = _selectedValues.contains(item.value);
//     return CheckboxListTile(
//       value: checked,
//       title: Text(item.label),
//       controlAffinity: ListTileControlAffinity.leading,
//       onChanged: (checked) =>
//           _onItemCheckedChange(item.value, checked, item.identity),
//     );
//   }
// }
//
// // ===================
