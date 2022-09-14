import 'dart:io';

// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:vsartist/Controllers/Auth_Controller.dart';
import 'package:vsartist/constants/svg_assets.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:launch_review/launch_review.dart';
import 'package:vsartist/core/router/app_route.dart';
import 'package:vsartist/global_variables.dart';
import 'package:vsartist/views/account/login.dart';
import 'package:vsartist/views/common/uidata.dart';
import 'package:vsartist/views/statistics/playlist/playlist_screen.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';

import 'a.dart';
import 'account/bloc/auth/auth_bloc.dart';
import 'add_artist/approve_recordlabel.dart';
import 'artist_features/music/music-home.dart';
import 'services/services_page.dart';
import 'artist_features/wallet/balance.dart';
import 'statistics/playlist/bloc/playlist_bloc.dart';
import 'statistics/statistics_screen.dart';
import 'upload/album-upload-instruction.dart';
import 'upload/singles-upload-instruction.dart';
import 'widgets/dashboard_card.dart';

class Dashboard extends StatefulWidget implements AppRoute {
  @override
  String get routeNam => routeName;

  static String get routeName => 'dashboard';

  @override
  Widget get page => this;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  initState() {
    super.initState();
    BlocProvider.of<PlaylistBloc>(context).load();
  }

  Material homeText(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      heading,
                      style: TextStyle(color: Color(color), fontSize: 15.0),
                    ),
                  ),
                  Material(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(24.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  dashboardGridView() {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      // var width = MediaQuery.of(context).size.width;
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                      child: DashboardCard(
                          title: "Singles Upload",
                          icon: SvgAssets.musicNote,
                          routeName: SinglesUploadInstruction.routeName),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child: DashboardCard(
                            title: "Album Upload",
                            icon: SvgAssets.musicAlbum,
                            routeName: AlbumUploadInstruction.routeName)),
                  ],
                )),
                SizedBox(height: width / 5),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                        child: DashboardCard(
                            title: "Balance",
                            icon: SvgAssets.wallet,
                            routeName: WalletBalance.routeName)),
                    // Expanded(
                    //     child: DashboardCard(
                    //         title: " Record Label",
                    //         icon: Icons.supervised_user_circle,
                    //         routeName: ApproveRecordLabel.routeName)),
                    SizedBox(width: 10),
                    Expanded(
                        child: DashboardCard(
                            title: "Analytics",
                            icon: SvgAssets.trend,
                            routeName: StatisticsScreen.routeName)),
                  ],
                )),
                SizedBox(height: width / 5),
                Expanded(
                    child: Row(children: [
                  Expanded(
                      child: DashboardCard(
                          title: "Artist Playlist",
                          icon: SvgAssets.playlist,
                          routeName: PlaylistScreen.routeName)),
                  //makeDashboardItem("Help", Icons.info),
                  // if (Platform.isAndroid)
                  //   DashboardCard(
                  //       title: "Services",
                  //       icon: Icons.work,
                  //       routeName: ServicesHome.routeName),
                  SizedBox(width: 10),
                  Expanded(
                      child: DashboardCard(
                          title: "Play Your Music",
                          icon: SvgAssets.share,
                          action: ()   {
                            // showDialog(context: context, builder: (c) => MyApp());

                            // LaunchReview.launch(
                            //     androidAppId: "com.vibespot.mobile",
                            //     iOSAppId: "1559309492");

                            // LaunchReview.launch();
                            StoreRedirect.redirect(
                                androidAppId: "com.vibespot.mobile",
                                iOSAppId: "585027354");
                          },
                          routeName: '')),
                ])),
              ])),
    );
  }

//         GridView.count(
//           crossAxisCount: 2,
//           padding: EdgeInsets.all(3.0),
//           children: <Widget>[
//             DashboardCard(
//                 title: "Singles Upload",
//                 icon: Icons.music_note,
//                 routeName: SinglesUploadInstruction.routeName),
//             DashboardCard(
//                 title: "Album Upload",
//                 icon: Icons.queue_music,
//                 routeName: AlbumUploadInstruction.routeName),

//             DashboardCard(
//                 title: " Record Label",
//                 icon: Icons.supervised_user_circle,
//                 routeName: ApproveRecordLabel.routeName),

//             DashboardCard(
//                 title: "Analytics",
//                 icon: Icons.library_music,
//                 routeName: StatisticsScreen.routeName),
//             //makeDashboardItem("Playlist", Icons.graphic_eq),
//             DashboardCard(
//                 title: "Balance",
//                 icon: Icons.attach_money,
//                 routeName: WalletBalance.routeName),
//             //makeDashboardItem("Help", Icons.info),
//             if (Platform.isAndroid)
//               DashboardCard(
//                   title: "Services",
//                   icon: Icons.work,
//                   routeName: ServicesHome.routeName),

//             DashboardCard(
//                 title: "Play Your Music",
//                 icon: Icons.share,
//                 action: () async {
//                   // showDialog(context: context, builder: (c) => MyApp());

//                   // LaunchReview.launch(
//                   //     androidAppId: "com.vibespot.mobile",
//                   //     iOSAppId: "585027354");

// //                      LaunchReview.launch();
// //                      StoreRedirect.redirect(
// //                          androidAppId: "com.vibespot.mobile",
// //                          iOSAppId: "585027354");
//                 },
//                 routeName: ''),
//             //makeDashboardItem("Statistics", Icons.show_chart)
//           ],
//         ),
//       );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (c, s) {
        if (s is UnAuthenticated && Navigator.canPop(context)) {
          Navigator.popUntil(context, (route) => !Navigator.canPop(context));
        }
      },
      builder: (context, state) {
        if(state is Authenticated)
          {
            AuthController authController = Get.put(AuthController());
            USER_ID.value=state.user!.id!.toInt();
            authController.saveFcmToken(token: fcmToken.value, userId: USER_ID.value);

          }

        if (state is Authenticated)
          return ScaffoldCommon(
            appTitle: 'Dashboard',
            // scaffoldState: scaffoldState,
            bodyData: dashboardGridView(),
            showDrawer: true,
          );
        return Login();
      },
    );
  }
}
