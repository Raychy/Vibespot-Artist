// import 'package:flutter/material.dart';
// import 'package:vsartist/views/account/account-lander.dart';
// import 'package:vsartist/views/account/forgot_password.dart';
// import 'package:vsartist/views/account/login.dart';
// import 'package:vsartist/views/account/record_label_forgot_password.dart';
// import 'package:vsartist/views/account/record_label_login.dart';
// import 'package:vsartist/views/account/record_label_signup.dart';
// import 'package:vsartist/views/account/signup.dart';
// import 'package:vsartist/views/account/signup_home.dart';
// import 'package:vsartist/views/add_artist/add_artist.dart';
// import 'package:vsartist/views/add_artist/approve_recordlabel.dart';
// import 'package:vsartist/views/artist_features/music/music-home.dart';
// import 'package:vsartist/views/artist_features/services/services_page.dart';
// import 'package:vsartist/views/artist_features/uploads/album-cover.dart';
// import 'package:vsartist/views/artist_features/uploads/album-upload-instruction.dart';
// import 'package:vsartist/views/artist_features/uploads/signles-upload-number.dart';
// import 'package:vsartist/views/artist_features/uploads/singles-upload-instruction.dart';
// import 'package:vsartist/views/artist_features/uploads/singles-upload.dart';
// import 'package:vsartist/views/artist_features/wallet/balance.dart';
// import 'package:vsartist/views/common/uidata.dart';
// import 'package:vsartist/views/dashboard.dart';
// import 'package:vsartist/views/onboarding/onboarding.dart';
// import 'package:vsartist/views/artist_features/wallet/withdraw.dart';
// import 'package:vsartist/views/record_label_dashboard.dart';
// import 'package:vsartist/views/record_lable_features/music/music-home.dart';
// import 'package:vsartist/views/record_lable_features/services/label_services_page.dart';
// import 'package:vsartist/views/record_lable_features/uploads/label_album-cover.dart';
// import 'package:vsartist/views/record_lable_features/uploads/label_album-upload-instruction.dart';
// import 'package:vsartist/views/record_lable_features/uploads/label_singlees-upload-number.dart';
// import 'package:vsartist/views/record_lable_features/uploads/label_singles-upload.dart';
// import 'package:vsartist/views/record_lable_features/uploads/singles-upload-instruction.dart';
// import 'package:vsartist/views/record_lable_features/wallet/balance.dart';

// final routes = <String, WidgetBuilder>{
//   UiData.onboarding: (BuildContext context) => new Onboarding(),
//   UiData.accountLander: (BuildContext context) => new AccountLander(),
//   UiData.login: (BuildContext context) => new Login(),
//   UiData.signupHome: (BuildContext context) => new SignUpHome(),
//   UiData.signup: (BuildContext context) => new SignUp(),
//   UiData.forgot_password: (BuildContext context) => new ForgotPassword(),
//   UiData.record_label_forgot_password: (BuildContext context) =>
//       new RecordLabelForgotPassword(),
//   UiData.recordLabelSignup: (BuildContext context) => new RecordLabelSignUp(),
//   UiData.recordLabelLogin: (BuildContext context) => new RecordLabelLoginPage(),
//   UiData.dashboard: (BuildContext context) => new Dashboard(),
//   UiData.record_labeldashboard: (BuildContext context) =>
//       new RecordLabelDashboard(),
//   UiData.addArtist: (BuildContext context) => new AddArtistScreen(),
//   UiData.approveRecordLabel: (BuildContext context) => new ApproveRecordLabel(),
//   UiData.signlesUploadInstruction: (BuildContext context) =>
//       new SinglesUploadInstruction(),
//   UiData.recordLabelSingleUploadInstruction: (BuildContext context) =>
//       new RecordLabelSinglesUploadInstruction(),
//   UiData.signlesUploadNumber: (BuildContext context) =>
//       new SinglesUploadNumber(),
//   UiData.recordLabelsignlesUploadNumber: (BuildContext context) =>
//       new RecordLabelSinglesUploadNumber(),
//   UiData.signlesUpload: (BuildContext context) => new SinglesUpload(),
//   UiData.recordLabelSinglesUpload: (BuildContext context) =>
//       new RecordLabelSinglesUpload(),
//   UiData.myBalance: (BuildContext context) => new WalletBalance(),
//   UiData.recordLabelmyBalance: (BuildContext context) =>
//       new RecordLabelWalletBalance(),
//   UiData.myMusic: (BuildContext context) => new MusicHome(),
//   UiData.record_label_myMusic: (BuildContext context) =>
//       new RecordLabelMusicHome(),
//   UiData.servicesHome: (BuildContext context) => new ServicesHome(),
//   UiData.recordLabelServicesHome: (BuildContext context) =>
//       new RecordLabelServicesHome(),
//   UiData.albumUploadInstruction: (BuildContext context) =>
//       new AlbumUploadInstruction(),
//   UiData.recordLabelAlbumUploadInstruction: (BuildContext context) =>
//       new RecordLabelAlbumUploadInstruction(),
//   UiData.albumCover: (BuildContext context) => new AlbumCover(),
//   UiData.recordLabelAlbumCover: (BuildContext context) =>
//       new RecordLabelAlbumCover(),
//   UiData.withdraw: (BuildContext context) => new Withdraw(),
//   UiData.recordLabelWithdraw: (BuildContext context) =>
//       new RecordLabelWalletBalance(),
// };
