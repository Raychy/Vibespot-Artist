// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:vsartist/core/router/app_route.dart';
// import 'package:vsartist/core/router/transissions/slide_side_route.dart';
// import 'package:vsartist/views/artist_features/uploads/uploads-model.dart';
// import 'package:vsartist/views/widgets/common-scaffold.dart';
// import 'package:vsartist/views/widgets/date_input_field.dart';
// import 'package:vsartist/views/widgets/dropdown_input.dart';
// import 'package:vsartist/views/widgets/forms.dart';

// import 'album_upload_file.dart';
// import 'cubit/album_cubit.dart';

// class AlbumCover extends StatefulWidget implements AppRoute {
//   @override
//   String get routeNam => routeName;

//   static String get routeName => 'album-cover';

//   @override
//   Widget get page => this;
//   @override
//   _AlbumCoverState createState() => _AlbumCoverState();
// }

// class _AlbumCoverState extends State<AlbumCover> {
//   FormsWidget formsWidget = FormsWidget();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   late AlbumAlbum _cubit;

//   File? _image;

//   @override
//   void initState() {
//     _cubit = AlbumAlbum();
//     super.initState();
//   }

//   AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

//   dispose() {
//     _cubit.close();
//     super.dispose();
//   }

//   selectGalleryImage() async {
//     var imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     _cubit.imageChanged(imageFile?.path);
//     setState(() {
//       _image = File(imageFile!.path);
//     });
//   }

//   _submit() {
//     autovalidateMode = AutovalidateMode.onUserInteraction;
//     if (formKey.currentState!.validate()) {
//       formKey.currentState!.save();

//       _cubit.createAlbum(context);
     
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldCommon(
//       showDrawer: false,
//       appTitle: 'Album Cover',
//       bodyData: Center(
//         child: Theme(
//           data: ThemeData(primarySwatch: Colors.orange),
//           child: BlocBuilder<AlbumAlbum, AlbumState>(
//             bloc: _cubit,
//             builder: (context, state) {
//               return Form(
//                   key: formKey,
//                   child: ListView(
//                       shrinkWrap: true,
//                       padding: EdgeInsets.only(left: 24.0, right: 24.0),
//                       children: <Widget>[
//                         SizedBox(height: 30.0),
//                         // formsWidget.sectionHeader('Album Banner'),
//                         formsWidget.fieldSpace(),
//                         formsWidget.imageInput(
//                             'Upload Cover', _image, selectGalleryImage),

//                         // formsWidget.sectionHeader('Album details'),
//                         formsWidget.fieldSpace(),
//                         formsWidget.textFieldHeader(context, 'Album title'),
//                         formsWidget.textInput(
//                             'Album title', _cubit.titleChanged,
//                             autovalidateMode: autovalidateMode),
//                         //formsWidget.fieldSpace(),
//                         SizedBox(height: 20.0),
//                         formsWidget.textFieldHeader(
//                             context, 'Album description'),
//                         formsWidget.textAreaInput(
//                             'Album description', _cubit.descriptionChanged,
//                             autovalidateMode: autovalidateMode),
//                         SizedBox(height: 20.0),
//                         DropdownInput<int>(
//                           key: ValueKey('release-track'),
//                           label: 'Number of tracks',
//                           hint: 'Number of tracks',
//                           value: state.trackCount,
//                           onChanged: _cubit.trackCountChanged,
//                           errorText: autovalidateMode ==
//                                       AutovalidateMode.onUserInteraction &&
//                                   state.trackCount == null
//                               ? 'Please select number of tracks'
//                               : null,
//                           options: [
//                             for (var i = 1; i < 15; i++)
//                               InputItem(i, '$i tracks')
//                           ],
//                         ),
//                         SizedBox(height: 20.0),
//                         SizedBox(
//                           width: 600,
//                           child: DateInputField(
//                             key: ValueKey('release-date'),
//                             margin: EdgeInsets.symmetric(),
//                             minimumYear: DateTime.now().year,
//                             firstDate: DateTime.now(),
//                             maximumYear: DateTime.now().year + 100,
//                             showLabel: true,
//                             label: 'Proposed Release Date',
//                             value: state.releaseDate,
//                             onChanged: _cubit.releaseDateChanged,
//                             errorText: autovalidateMode ==
//                                         AutovalidateMode.onUserInteraction &&
//                                     state.releaseDate == null
//                                 ? 'Please enter valid release date'
//                                 : null,
//                           ),
//                         ),
//                         SizedBox(height: 30.0),
//                         Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: formsWidget.wideButton(
//                                 'NEXT', context, _submit,
//                                 isLoading: state.isLoading,
//                                 disable: state.isLoading)),
//                         SizedBox(height: 50.0),
//                       ]));
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
