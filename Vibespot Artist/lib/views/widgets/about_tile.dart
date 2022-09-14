import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vsartist/constants/image_assets.dart';
import 'package:vsartist/constants/strings.dart';

class MyAboutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var actions = [
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            showLicensePage(
                context: context,
                applicationName: Strings.APP_TITLE,
                applicationIcon: Image.asset(ImageAssets.LOGO, width: 30));
          },
          child: Text('View Licenses')),
      TextButton(onPressed: Navigator.of(context).pop, child: Text('Close'))
    ];
    var title = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ImageAssets.LOGO, width: 30),
        SizedBox(width: 20),
        Text('VS Artist')
      ],
    );
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListTile(
          onTap: () {
            showDialog(
                context: context,
                builder: (c) => Platform.isIOS
                    ? CupertinoAlertDialog(title: title, actions: actions)
                    : AlertDialog(
                        title: title,
                        actions: actions,
                      ));
            // showAboutDialog(context: context);
            // showLicensePage(context: context);
          },
          leading: Image.asset(ImageAssets.LOGO, width: 30),
          title: Text('About App')),
    );

    // AboutListTile(
    //   applicationIcon: Image.asset(ImageAssets.LOGO, width: 60),
    //   icon: Image.asset(UiData.logo, width: 40),
    //   aboutBoxChildren: <Widget>[
    //     SizedBox(
    //       height: 10.0,
    //     ),
    //     Text("Developed By Intemporel", style: TextStyle(color: Colors.orange)),
    //     Text("VS Music", style: TextStyle(color: Colors.orange)),
    //   ],
    //   applicationName: Strings.APP_TITLE,
    //   applicationVersion: "1.0.1",
    //   applicationLegalese: "License to VSM",
    // );
  }
}
