// import 'package:flutter/material.dart';
// import 'package:vsartist/core/router/app_route.dart';
// import 'package:vsartist/views/account/user.dart';
// import 'package:vsartist/views/artist_features/uploads/upload-common.dart';
// import 'package:vsartist/views/artist_features/uploads/uploads-model.dart';
// import 'package:vsartist/views/record_lable_features/label_global/functions.dart';
// import 'package:vsartist/views/record_lable_features/label_global/networks.dart';
// import 'package:vsartist/views/widgets/forms.dart';
// import 'package:vsartist/views/widgets/recordlabel_common-scaffold.dart';

// class AddArtistScreen extends StatefulWidget implements AppRoute {
//   @override
//   String get routeNam => routeName;

//   static String get routeName => 'add-artist-screen';

//   @override
//   Widget get page => this;
//   final int? pages;
//   final int? pager;
//   final String? releaseName;
//   final UploadAlbum? uploadAlbum;

//   AddArtistScreen({this.pages, this.pager, this.releaseName, this.uploadAlbum});
//   @override
//   _AddArtistScreenState createState() => _AddArtistScreenState();
// }

// class _AddArtistScreenState extends State<AddArtistScreen>
//     with SingleTickerProviderStateMixin {
//   AnimationController? controller;
//   Animation<double>? animation;

//   FormsWidget formsWidget = FormsWidget();
//   Functions functions = Functions();
//   UploadCommon uploadCommon = UploadCommon();
//   final scaffoldState = GlobalKey<ScaffoldState>();
//   final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
//   Music musicUpload = new Music();
//   UploadAlbum? uploadAlbum;
//   NetworkRequest network = NetworkRequest();
//   List<ArtistModel> artists = [];
//   ArtistModel? artist;
//   String? _artistValue;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     functions.checkInternet(scaffoldState);
//     getAllArtists();
//     // uploadAlbum = widget.uploadAlbum;
//   }

//   void getAllArtists() async {
//     List<ArtistModel> artistsModel =
//         (await network.getAllArtists(context: context) as List<ArtistModel>);
//     setState(() {
//       artists = artistsModel;
//     });
//   }

//   onSavedTrackTitle(value) => setState(() {
//         musicUpload.title = value;
//       });
//   onSavedTrackDescription(value) => setState(() {
//         musicUpload.description = value;
//       });

//   onSavedFeatureArtists(value) => setState(() {
//         musicUpload.featureBy = value;
//       });

//   onSavedProducedBy(value) => setState(() {
//         musicUpload.producedBy = value;
//       });

//   onChangeGenre(value) => setState(() {
//         musicUpload.genre = value;
//       });

//   void _submit() async {
//     final form = formKey.currentState!;
//     if (form.validate()) {
//       form.save();

//       networkBloc.addArtist({"artist_id": artist!.userId.toString()}, context);
//       networkBloc.snacksBar.listen((data) {
//         scaffoldState.currentState!.showSnackBar(new SnackBar(
//             duration: Duration(seconds: 50), content: new Text(data)));
//       });
//     }
//   }

//   forms() => Container(
//         child: new Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             new Form(
//               key: formKey,
//               child: new Column(
//                 children: <Widget>[
//                   new Padding(
//                     padding: const EdgeInsets.only(top: 1),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         new Padding(
//                           padding: const EdgeInsets.only(top: 1),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               formsWidget.sectionHeader(
//                                   'Select Artist to map under record label'),
//                               // formsWidget.fieldSpace(),

//                               formsWidget.fieldSpace(),

//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 24.0, horizontal: 16.0),
//                                 child: new FormField(
//                                   builder: (FormFieldState state) {
//                                     return InputDecorator(
//                                       decoration: InputDecoration(
//                                         filled: true,
//                                         fillColor: Colors.transparent,
//                                         hintText: 'Select Artist',
//                                         hintStyle:
//                                             new TextStyle(color: Colors.white),
//                                         contentPadding: EdgeInsets.symmetric(
//                                             vertical: 0, horizontal: 3),
//                                         enabledBorder: inputBorder(),
//                                         errorBorder: inputBorder(),
//                                         border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(22),
//                                         ),
//                                       ),
//                                       child: Theme(
//                                         data: ThemeData.dark(),
//                                         child: DropdownButtonFormField<
//                                             ArtistModel>(
//                                           isExpanded: true,
//                                           isDense: true,
//                                           iconEnabledColor: Colors.amber,
//                                           elevation: 120,
//                                           hint: DropdownMenuItem(
//                                             child: Text(
//                                               "Select Artist",
//                                               style: TextStyle(
//                                                   fontSize: 18.0,
//                                                   fontWeight: FontWeight.w500,
//                                                   color: Colors.amber),
//                                             ),
//                                           ),
//                                           items: _buildArtistsDropDownItems(
//                                               artists),
//                                           value: artist,
//                                           onChanged: (ArtistModel? value) {
//                                             setState(() {
//                                               artist = value;
//                                               print(artist!.userId);
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),

//                               formsWidget.fieldSpace(),
//                               SizedBox(height: 20),
//                               addArtistButton(),
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

//   addArtistButton() {
//     return StreamBuilder<bool>(
//         stream: networkBloc.showProgress,
//         initialData: false,
//         builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//           if (snapshot.data!) {
//             return new Center(child: CircularProgressIndicator());
//           } else {
//             return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: formsWidget.wideButton('Add Artist', context, _submit));
//           }
//         });
//   }

//   List<DropdownMenuItem<ArtistModel>> _buildArtistsDropDownItems(
//       List<ArtistModel> artsts) {
//     return artsts.map((ArtistModel artist) {
//       return DropdownMenuItem<ArtistModel>(
//         child: Text(
//           artist.stageName!,
//           style: TextStyle(
//               fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.amber),
//         ),
//         value: artist,
//       );
//     }).toList();
//   }

//   inputBorder() {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.elliptical(0, 0)),
//       borderSide: const BorderSide(color: Colors.white, width: 0.0),
//     );
//   }

//   body() => SingleChildScrollView(
//           child: Column(
//         mainAxisSize: MainAxisSize.max,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           // SizedBox(height: 4),
//           Padding(padding: EdgeInsets.all(15), child: forms())
//         ],
//       ));

//   @override
//   Widget build(BuildContext context) {
//     return RecordLabelCommonScaffold(
//       scaffoldState: scaffoldState,
//       appTitle: 'Add Artist',
//       bodyData: body(),
//       showDrawer: false,
//     );
//   }
// }
