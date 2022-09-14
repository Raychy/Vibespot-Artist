import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/constants/dimens.dart';
import 'package:vsartist/views/account/bloc/auth/auth_bloc.dart';
import 'package:vsartist/views/account/profile_screen.dart';
import 'package:vsartist/views/add_artist/approve_recordlabel.dart';
import 'package:vsartist/views/services/services_page.dart';
import 'package:vsartist/views/artist_features/wallet/balance.dart';
import 'package:vsartist/views/statistics/statistics_screen.dart';
import 'package:vsartist/views/statistics/track/track_screen.dart';
import 'package:vsartist/views/upload/album-upload-instruction.dart';
import 'package:vsartist/views/upload/singles-upload-instruction.dart';
import 'package:vsartist/views/widgets/about_tile.dart';

import 'cached_image.dart';
import 'drawer_item.dart';

class CommonDrawer extends StatefulWidget {
  @override
  _CommonDrawerState createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  @override
  void initState() {
    super.initState();
  }

  Widget drawerList(title, {widget, url, web, required theme}) => Container(
        height: 45,
        child: ListTile(
          onTap: () {
            Navigator.of(context).pop();
            url != null
                ? Navigator.of(context).pushNamed(url)
                : Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return widget;
                    }),
                  );
          },
          title: Text(title, style: theme.textTheme.caption),
        ),
      );

  authDrawer(state) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      var user = state.user;
      return Expanded(
          child: Column(
              // shrinkWrap: true, padding: EdgeInsets.zero,
              children: <Widget>[
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Card(
                margin: const EdgeInsets.only(left: Dimens.PADDING_EX_SMALL),
                clipBehavior: Clip.antiAlias,
                shape: CircleBorder(),
                child: CachedImage(
                    height: 80,
                    width: 80,
                    url: user?.artistImage ?? user?.image ?? ''),
              ),
            ),
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                      '${user?.firstname ?? ''} ${user?.surname ?? ''} -${user?.stageName}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Colors.white70)),
                )),
            SizedBox(height: 4),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(user?.email ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(color: Colors.white60),
                        overflow: TextOverflow.ellipsis))),

            SizedBox(height: 10),
            // editProfile(),
            Divider(
              thickness: 1,
              color: AppColors.PRIMARY,
            ),

            Divider(height: 40),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.PADDING_SMALL - 10),
              child: ListView(
                children: [
                  // DrawerItem(
                  //     title: 'Home',
                  //     routeName: Dashboard.routeName,
                  //     icon: Icon(CupertinoIcons.home)),
                  DrawerItem(
                      title: 'Upload Singles',
                      routeName: SinglesUploadInstruction.routeName,
                      icon: Icon(CupertinoIcons.cloud_upload)),
                  DrawerItem(
                      title: 'Upload Album',
                      routeName: AlbumUploadInstruction.routeName,
                      icon: Icon(CupertinoIcons.cloud_upload_fill)),
                  DrawerItem(
                      title: 'My Tracks',
                      routeName: TrackScreen.routeName,
                      icon: Icon(CupertinoIcons.music_albums_fill)),
                  DrawerItem(
                      title: 'Wallet',
                      routeName: WalletBalance.routeName,
                      icon: Icon(CupertinoIcons.money_dollar)),
                  // if (Platform.isAndroid)
                  //   DrawerItem(
                  //       title: 'Services',
                  //       routeName: StatisticsScreen.routeName,
                  //       icon: Icon(Icons.scatter_plot_sharp)),
                  DrawerItem(
                      title: 'Edit Profile',
                      routeName: ProfileScreen.routeName,
                      icon: Icon(CupertinoIcons.person)),
                  DrawerItem(
                      title: 'Logout',
                      action: () => Auth.add(LogOut()),
                      icon: Icon(Icons.logout)),
                  Divider(height: 40),
                ],
              ),
            )),
          ]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Drawer(
          child: Theme(
            data: Theme.of(context),
            child: Container(
                // padding: const EdgeInsets.symmetric(
                //     horizontal: Dimens.PADDING_SMALL),
                color: Theme.of(context).primaryColor,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // if (state is Authenticated)
                      authDrawer(state)
                      // else
                      //   visitorsDrawer(state)
                      ,
                      MyAboutTile(),
                      SizedBox(height: 50)
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
