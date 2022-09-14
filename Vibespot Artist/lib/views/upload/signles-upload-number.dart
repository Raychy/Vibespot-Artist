// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:vsartist/constants/dimens.dart';
// import 'package:vsartist/core/router/app_route.dart';
// import 'package:vsartist/core/router/transissions/slide_up_route.dart';
// import 'package:vsartist/views/artist_features/music/cubit/album_cubit.dart';
// import 'package:vsartist/views/artist_features/uploads/singles-upload.dart';
// import 'package:vsartist/views/artist_features/uploads/uploads-model.dart';
// import 'package:vsartist/views/widgets/common-scaffold.dart';
// import 'package:vsartist/views/widgets/date_input_field.dart';
// import 'package:vsartist/views/widgets/dropdown_input.dart';
// import 'package:vsartist/views/widgets/forms.dart';

 

// class SinglesUploadNumber extends StatefulWidget implements AppRoute {
//   @override
//   String get routeNam => routeName;

//   static String get routeName => 'singles-upload-number';

//   @override
//   Widget get page => this;
//   @override
//   _SinglesUploadNumberState createState() => _SinglesUploadNumberState();
// }

// class _SinglesUploadNumberState extends State<SinglesUploadNumber> {
//   FormsWidget formsWidget = FormsWidget();
//   final scaffoldState = GlobalKey<ScaffoldState>();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   late AlbumAlbum _cubit;

//   String releaseNameTooltip =
//       'This is used to identify the upload of tracks and it is not seen by your listener';
 

//   var uploadDate = DateTime.now();
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

 
//   _submit() {
//     autovalidateMode = AutovalidateMode.onUserInteraction;
//     if (formKey.currentState!.validate()) {
//       formKey.currentState!.save();

//       _cubit.createRelease(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldCommon(
//       scaffoldState: scaffoldState,
//       appTitle: 'Number of Tracks',
//       bodyData: Theme(
//         data: ThemeData(primarySwatch: Colors.orange),
//         child: BlocBuilder<AlbumAlbum, AlbumState>(
//             bloc: _cubit,
//             builder: (context, state) => SafeArea(
//                   child: Form(
//                       key: formKey,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: Dimens.PADDING_SMALL),
//                         child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               SizedBox(height: 30.0),
//                               // formsWidget.sectionHeader('Release details'),
//                               // SizedBox(height: 15.0),
//                              SizedBox(height: 20.0),
//                               formsWidget.textFieldHeader(
//                                   context, 'Release Name'),
//                               formsWidget.textInput(
//                                   'Release Name', _cubit.titleChanged,
//                                   autovalidateMode: autovalidateMode),
//                               // SizedBox(height: 20.0),
//                               // DropdownInput<int>(
//                               //   key: ValueKey('release-track'),
//                               //   label: 'Number of tracks',
//                               //   hint: 'Number of tracks',
//                               //   value: state.trackCount,
//                               //   onChanged: _cubit.trackCountChanged,
//                               //   errorText: autovalidateMode ==
//                               //               AutovalidateMode
//                               //                   .onUserInteraction &&
//                               //           state.trackCount == null
//                               //       ? 'Please select number of tracks'
//                               //       : null,
//                               //   options: [
//                               //     for (var i = 1; i < 15; i++)
//                               //       InputItem(i, '$i tracks')
//                               //   ],
//                               // ),
//                               SizedBox(height: 20.0),
//                               SizedBox(
//                                 width: 600,
//                                 child: DateInputField(
//                                   key: ValueKey('release-date'),
//                                   margin: EdgeInsets.symmetric(),
//                                   minimumYear: DateTime.now().year,
//                                   firstDate: DateTime.now(),
//                                   maximumYear: DateTime.now().year + 100,
//                                   showLabel: true,
//                                   label: 'Proposed Release Date',
//                                   value: state.releaseDate,
//                                   onChanged: _cubit.releaseDateChanged,
//                                   errorText: autovalidateMode ==
//                                               AutovalidateMode
//                                                   .onUserInteraction &&
//                                           state.releaseDate == null
//                                       ? 'Please enter valid release date'
//                                       : null,
//                                 ),
//                               ), 
//                               Spacer(),
//                               SizedBox(height: 15.0),
//                               Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: formsWidget.wideButton(
//                                       'NEXT', context, _submit)),
//                               SizedBox(height: 50.0),
//                             ]),
//                       )),
//                 )),
//       ),
//       showDrawer: false,
//     );
//   }
// }
